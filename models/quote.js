const db = require('../database');

exports.getAllQuotes = async () => {
  const query = 'SELECT * FROM quotes ORDER BY id';
  const { rows } = await db.query(query);
  return rows;
};


exports.add = async (quote) => {
  return await db.getPool()
    .query(`INSERT INTO quotes(en_text, ch_text, chapter_id, location_id, created_at)
            VALUES($1, $2, $3, $4, CURRENT_TIMESTAMP) RETURNING *`,
      [quote.enText, quote.chText, quote.chapterId, quote.locationId]);
};

exports.update = async (quote) => {
  return await db.getPool()
    .query("UPDATE quotes SET en_text = $1, ch_text = $2, chapter_id = $3, location_id = $4 WHERE id = $5 RETURNING *",
      [quote.enText, quote.chText, quote.chapterId, quote.locationId, quote.id]);
};

exports.upsert = async (quote) => {
  if (quote.id) {
    return exports.update(quote);
  } else {
    return exports.add(quote);
  }
};

exports.get = async (id) => {
  const { rows } = await db.getPool().query("SELECT * FROM quotes WHERE id = $1", [id]);
  return db.camelize(rows)[0];
};

exports.findByChapterId = async (chapterId) => {
  const { rows } = await db.getPool().query(`
    SELECT quotes.*, locations.name as location_name
    FROM quotes
    LEFT JOIN locations ON locations.id = quotes.location_id
    WHERE chapter_id = $1
    ORDER BY created_at DESC;
  `, [chapterId]);
  return db.camelize(rows);
};

exports.findByLocationId = async (locationId) => {
  const { rows } = await db.getPool().query(`
    SELECT quotes.*, chapters.name as chapter_name
    FROM quotes
    LEFT JOIN chapters ON chapters.id = quotes.chapter_id
    WHERE location_id = $1
    ORDER BY created_at DESC;
  `, [locationId]);
  return db.camelize(rows);
};