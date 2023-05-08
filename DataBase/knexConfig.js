const knexConfig = {
  client: "mysql2",
  connection: {
    host: "localhost",
    user: "root",
    password: "cg7ThKa8Bd@r5zyi",
    database: "ohmydog",
  },
};

const knex = require('knex')(knexConfig)

module.exports = knex

