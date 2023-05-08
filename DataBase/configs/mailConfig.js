const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  secure: true,
  auth: {
    user: 'BitBuilders2023@gmail.com',   //capaz es sin mayuscula?
    pass: 'Bit123456'
  }
});

module.exports = transporter