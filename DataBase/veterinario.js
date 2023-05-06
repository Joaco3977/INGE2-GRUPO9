// AGREGAR VETERINARIO - POST con datos de veterinario, chequear DNI no exista, agregar a BD

// ELIMINAR VETERINARIO - POST con DNI dado eliminar coincidencia en la BD

// EDITAR VETERINARIO - POST con datos nuevos, chequear DNI 
                //DE PERMITIR CAMBIOS EN DNI, TABLAS FORANEAS???

const knex = require("knex")({
    client: "mysql2",
    connection: {
      host: "localhost",
      user: "root",
      password: "cg7ThKa8Bd@r5zyi",
      database: "ohmydog",
    },
});

function checkVeterinario (mail, pass) {
  knex.select('PASSWORD')
  .from('veterinario')
  .where('MAIL', '=', mail)
  .then(rows => {
    if (rows.length > 0 && rows[0].PASSWORD == pass) {
        return ({ dato : rows[0] });
    }
    return false;
  })
  .catch(error => {
    console.error(error);
    return false;
  });
}

module.exports = { checkVeterinario };