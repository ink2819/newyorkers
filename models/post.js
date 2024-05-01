const db = require('../database');

exports.findByLocationId = async (locationId) => {
  try {
      const { rows } = await db.getPool().query(`
          SELECT * FROM posts
          WHERE location_id = $1
      `, [locationId]);
      return rows;
  } catch (err) {
      throw new Error('Error fetching posts: ' + err.message);
  }
};
