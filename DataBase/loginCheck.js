const knex = require('./configs/knexConfig.js')
const mailSender = require('./configs/mailConfig.js')
const crypto = require('crypto');

const generarPassword = () => {
  const longitud = 10;
  const caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  const password = crypto.randomBytes(longitud)
  .map((byte) => caracteres[byte % caracteres.length])
  .join('');
  return password
}

const enviarMailPassword = async (destinatario) => {
  const password = generarPassword();

  const asunto = 'Nueva contraseña!';
  const mensaje = `Su nueva contraseña es: ${password}`;

  mailSender.sendMail({
    to: destinatario,
    subject: asunto,
    text: mensaje
  }).then(() => {
    console.log('Correo electrónico enviado');
    return true;
  }).catch((error) => {
    console.error('Error al enviar el correo electrónico:', error);
    return false;
});
}

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

module.exports = { checkAdmin, checkCliente, checkVeterinario, enviarMailPassword };