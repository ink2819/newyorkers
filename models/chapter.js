const db = require('../database');

const Chapter = {
  all: async () => {
    const { rows } = await db.getPool().query("SELECT * FROM chapters ORDER BY id");
    return db.camelize(rows);
  },
  
  add: async (chapter) => {
    const { rows } = await db.getPool()
      .query("INSERT INTO chapters(name, source, source_link) VALUES($1, $2, $3) RETURNING *",
        [chapter.name, chapter.source, chapter.sourceLink]);
    return db.camelize(rows)[0];
  },
  
  get: async (id) => {
    const { rows } = await db.getPool().query("SELECT * FROM chapters WHERE id = $1", [id]);
    return db.camelize(rows)[0];
  },
  
  update: async (chapter) => {
    const { rows } = await db.getPool()
      .query("UPDATE chapters SET name = $1, source = $2, source_link = $3 WHERE id = $4 RETURNING *",
        [chapter.name, chapter.source, chapter.sourceLink, chapter.id]);
    return db.camelize(rows)[0];
  },
  
  upsert: async (chapter) => {
    if (chapter.id) {
      return Chapter.update(chapter);
    } else {
      return Chapter.add(chapter);
    }
  },

  getLocationsWithQuotes: async (chapterId) => {
    const query = `
      SELECT locations.id as location_id, locations.name as location_name,
        quotes.id as quote_id, quotes.en_text, quotes.ch_text
      FROM locations
      LEFT JOIN quotes ON locations.id = quotes.location_id
      WHERE quotes.chapter_id = $1
      ORDER BY locations.id, quotes.id
    `;
    const { rows } = await db.getPool().query(query, [chapterId]);

    // Group quotes by locations
    const locationsWithQuotes = rows.reduce((acc, row) => {
      const { location_id, location_name, quote_id, en_text, ch_text } = row;
      if (!acc[location_id]) {
        acc[location_id] = { id: location_id, name: location_name, quotes: [] };
      }
      if (quote_id && en_text && ch_text) {
        acc[location_id].quotes.push({ id: quote_id, enText: en_text, chText: ch_text });
      }
      return acc;
    }, {});

    return Object.values(locationsWithQuotes);
  },
};

module.exports = Chapter;