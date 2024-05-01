const db = require('../database');

exports.all = async () => {
  const { rows } = await db.getPool().query("SELECT * FROM locations ORDER BY id");
  return db.camelize(rows);
};

exports.add = async (location) => {
  const { rows } = await db.getPool()
    .query("INSERT INTO locations(name, latitude, longitude) VALUES($1, $2, $3) RETURNING *",
      [location.name, location.latitude, location.longitude]);
  return db.camelize(rows)[0];
};

exports.get = async (id) => {
  const { rows } = await db.getPool().query("SELECT * FROM locations WHERE id = $1", [id]);
  return db.camelize(rows)[0];
};

exports.getWithDetails = async (id) => {
  const location = await this.get(id);
  const { rows } = await db.getPool().query(`
    SELECT quotes.en_text, quotes.ch_text, chapters.name, chapters.source, chapters.source_link 
    FROM quotes 
    JOIN chapters ON quotes.chapter_id = chapters.id 
    WHERE quotes.location_id = $1
  `, [id]);
  const chapters = rows.reduce((acc, row) => {
    const { name, source, source_link, en_text, ch_text } = row;
    if (!acc[name]) {
      acc[name] = { name, source, source_link, quotes: [] };
    }
    acc[name].quotes.push({ enText: en_text, chText: ch_text });
    return acc;
  }, {});
  return { location, chapters: Object.values(chapters) };
};

exports.update = async (location) => {
  const { rows } = await db.getPool()
    .query("UPDATE locations SET name = $1, latitude = $2, longitude = $3 WHERE id = $4 RETURNING *",
      [location.name, location.latitude, location.longitude, location.id]);
  return db.camelize(rows)[0];
};

exports.upsert = async (location) => {
  if (location.id) {
    return exports.update(location);
  } else {
    return exports.add(location);
  }
};