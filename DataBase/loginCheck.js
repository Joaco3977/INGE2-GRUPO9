const knex = require('./configs/knexConfig.js')
const crypto = require('crypto');
const transporter = require('./configs/mailConfig.js')

const generarPassword = () => {
  longitud = 10
  const buffer = crypto.randomBytes(longitud);
  const password = buffer.toString('base64').slice(0, longitud);
  return password;
}

const enviarMailPassword = async (destinatario) => {
  
  const password = generarPassword();
  
  const asunto = 'Nueva contraseña!';
  const mensaje = `Su nueva contraseña es: ${password}`;

  transporter.sendMail({
    from: 'BitBuilders2023@gmail.com',
    to: destinatario,
    subject: asunto,
    text: mensaje,
  }).then(() => {
    return password;
  }).catch((error) => {
    console.error('Error al enviar el correo electrónico:', error);
    return false;
});
  return password
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

module.exports = { checkAdmin, checkCliente, checkVeterinario, generarPassword , enviarMailPassword};