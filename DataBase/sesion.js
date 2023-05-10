const knex = require('./configs/knexConfig.js')

function generarToken() {
    const uuid = require('uuid');
    const token = uuid.v4(); // Genera un token único aleatorio
    return token;
}

/*
async function getInfoQuien (token) {
  await knex('sesion')
    .select('sesion.ROL', 'cliente.NOMBREAPELLIDO AS nombre_cliente', 'cliente.DNI AS dni_cliente', 'veterinario.NOMBREAPELLIDO AS nombre_veterinario', 'veterinario.DNI AS dni_veterinario')
    .where('sesion.TOKEN', token)
    .leftJoin('cliente', 'sesion.MAIL', 'cliente.MAIL')
    .leftJoin('veterinario', 'sesion.MAIL', 'veterinario.MAIL')
    .then((rows) => {
      if (rows.length === 0) {
        return false;
      }
      const rol = rows[0].ROL;
      if (rol === 1) {
        return {
          rol,
          nombre: rows[0].nombre_cliente,
          dni: rows[0].dni_cliente,
        };
      } else if (rol === 2) {
        return {
          rol,
          nombre: rows[0].nombre_veterinario,
          dni: rows[0].dni_veterinario,
        };
      } else {
        return false;
      }
    });
}
*/

const almacenarToken = async (token, mail, dni, rol) => {
    const nuevoToken = {
      TOKEN: token,
      MAIL: mail,
      DNI: dni,
      ROL: rol
    }
    await knex('sesion').insert(nuevoToken)
      .then (() => {
        
      })
      .catch ((error) => {
        console.error(error)
      })
}

const validarToken = async (token) => {
    return knex('sesion').select('*').where('TOKEN', '=', token).first()
      .then((resultado) => {
        if (resultado !== undefined) {
          return ({ rol: resultado.ROL , dni: resultado.DNI })
        } else {
          return ({ rol: 0, tab: 'Iniciar Sesion' })
        }
      })
      .catch((error) => {
        console.error(error)
        return ({ rol: 0, tab: 'Iniciar Sesion' })
      })
}

const eliminarToken = async (token) => {
  return knex('sesion').where('TOKEN', token).del()
    .then(() => {
      return true
    })
    .catch(() => {
      return false
    })
}

const limpiarTokens = async () => {
  return knex('sesion').del()
    .then(() => {
      console.log("\x1b[31m%s\x1b[0m", "Tabla de TOKENS eliminada correctamente!")
    })
    .catch((error) => {
      console.error(error)
    })
    .finally (() => {
      knex.destroy()
    })
}

module.exports = {generarToken, almacenarToken, validarToken, eliminarToken, limpiarTokens}; //getInfoQuien