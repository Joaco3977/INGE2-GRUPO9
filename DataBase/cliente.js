// VER PERFIL CLIENTE - POST segun DNI ya obtenido traer el perfil de un cliente existente

// AGREGAR CLIENTE - POST con datos de cliente, chequear DNI no exista, agregar a BD

// VER LISTA CLIENTES - GET traer todos los clientes

// FILTRAR LISTA CLIENTES - POST con un DNI dado traer todos los matches

/*   buscas el num = 987
Pedro Gomez 40987867
Joaquin Gomez 41987867
Fafafa Gomez 42987867
Lautaro Gomez 30987867
*/

//  ELIMINAR CLIENTE - POST con un DNI dado eliminar la coincidencia

// EDITAR CLIENTE - POST con datos nuevos, chequear DNI 
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

const checkCliente = async (mail, pass) => {
  try {
    const resultado = await knex('cliente').select('*').where('MAIL', '=', mail).andWhere('PASSWORD', '=', pass).first();
    if (resultado === undefined) {
      return false;
    } else return resultado;
  } catch (error) {
    console.error(error)
    return false;
  } finally {
    knex.destroy();
  }
};

module.exports = { checkCliente };