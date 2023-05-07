const knex = require('../OhMyDog/src/db/knexConfig.js')

function generarToken() {
    const uuid = require('uuid');
    const token = uuid.v4(); // Genera un token único aleatorio
    return token;
  }

const almacenarToken = async (token, mail, rol) => {
    const nuevoToken = {
      TOKEN: token,
      MAIL: mail,
      ROL: rol
    }
    await knex('sesion').insert(nuevoToken)
      .then (() => {
        console.log('Token insertado correctamente');
      })
      .catch ((error) => {
        console.error(error)
      })
}

const validarToken = async (token) => {
    return knex('sesion').select('*').where('TOKEN', '=', token).first()
      .then((resultado) => {
        if (resultado !== undefined) {
          return ({ rol: resultado.ROL })
        } else {
          return ({ rol: 0, tab: 'Iniciar Sesion' })
        }
      })
      .catch((error) => {
        console.error(error)
        return ({ rol: 0, tab: 'Iniciar Sesion' })
      })
}

module.exports = {generarToken, almacenarToken, validarToken};