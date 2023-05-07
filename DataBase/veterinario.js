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

const checkVeterinario = async (mail, pass) => {
  try {
    const resultado = await knex('veterinario').select('*').where('MAIL', '=', mail).andWhere('PASSWORD', '=', pass).first();
    if (resultado === undefined) {
      return false;
    } else return resultado;
  } catch (error) {
    console.error(error)
    return false;
  }
};

module.exports = { checkVeterinario };