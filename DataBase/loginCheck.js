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
  
  const asunto = '¡Bienvenido a la veterinaria OhMyDog!';
  const mensaje = `Con su mail y esta contraseña puede ingresar a nuestro sitio. \n Su nueva contraseña es: ${password}`;

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

const enviarMail = async (asunto, mensaje, destinatario) => {
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
    if (mail == 'admin@admin' && pass == '123') {
        return true;
    } return false;
}

const checkCliente = async (mail, pass) => {
    try {
      const resultado = await knex('cliente').select('*').where('MAIL', '=', mail).andWhere('PASSWORD', '=', pass).andWhere('ELIMINADO', 0).first();
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
      const resultado = await knex('veterinario').select('*').where('MAIL', '=', mail).andWhere('PASSWORD', '=', pass).andWhere('ELIMINADO', 0).first();
      if (resultado === undefined) {
        return false;
      } else return resultado;
    } catch (error) {
      console.error(error)
      return false;
    }
  };

module.exports = { checkAdmin, checkCliente, checkVeterinario, generarPassword , enviarMailPassword, enviarMail };