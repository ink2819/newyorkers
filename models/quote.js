const db = require('../database');

exports.getAllQuotes = async () => {
  const query = 'SELECT * FROM quotes ORDER BY id';
  const { rows } = await db.query(query);
  return rows;
};


exports.get = async (id) => {
  const { rows } = await db.query("SELECT * FROM quotes WHERE id = $1", [id]);
  return rows[0];  
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