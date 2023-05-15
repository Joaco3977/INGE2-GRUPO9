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

const enviarMailPaseador = async (nombre, destinatario) => {
  const asunto = 'Bienvenido Paseador!';
  const mensaje = `Hola ${nombre}, te comunicamos que ya estas registrado como paseador en OhMyDog!`;

  let pude = false

  transporter.sendMail({
    from: 'BitBuilders2023@gmail.com',
    to: destinatario,
    subject: asunto,
    text: mensaje,
  }).then(() => {
    pude = true;
  }).catch((error) => {
    console.error('Error al enviar el correo electrónico:', error);
    return false;
  })
  return true
}

function checkAdmin (mail, pass) {
    if (mail == 'admin@admin' && pass == '357') {
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

module.exports = { checkAdmin, checkCliente, checkVeterinario, generarPassword , enviarMailPassword, enviarMailPaseador };