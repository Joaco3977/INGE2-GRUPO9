const knex = require('./configs/knexConfig.js')

const Consola = require ('./serverFunctions.js')

function generarToken() {
    const uuid = require('uuid');
    const token = uuid.v4(); // Genera un token único aleatorio
    return token;
}

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
      Consola.mensaje("\x1b[31m%s\x1b[0m", "Tabla de TOKENS eliminada correctamente!")
    })
    .catch((error) => {
      console.error(error)
    })
    .finally (() => {
      knex.destroy()
    })
}

module.exports = {generarToken, almacenarToken, validarToken, eliminarToken, limpiarTokens}; //getInfoQuien