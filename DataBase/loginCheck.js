const knex = require('../OhMyDog/src/db/knexConfig.js')

function checkAdmin (mail, pass) {
    if (mail == 'OhMyDog@admin.com' && pass == '357') {
        return true;
    } return false;
}

const checkCliente = async (mail, pass) => {
    try {
      const resultado = await knex('cliente').select('*').where('MAIL', '=', mail).andWhere('PASSWORD', '=', pass).first();
      if (resultado === undefined) {
        return false;
      } else return resultado;
    } catch (error) {
      console.error(error)
      return false;
    }
};

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

module.exports = { checkAdmin, checkCliente, checkVeterinario};