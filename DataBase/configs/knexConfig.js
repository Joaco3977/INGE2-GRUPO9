const knexConfig = {
  client: "mysql2",
  connection: {
    host: "localhost",
    user: "root",
    password: "12345",
    database: "ohmydog",
  },
};

const knex = require('knex')(knexConfig)

module.exports = knex;

