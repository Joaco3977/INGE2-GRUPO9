const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'smtp-relay.sendinblue.com',
  port: 465,
  secure: true,
  auth: {
    user: 'BitBuilders2023@gmail.com',   //capaz es sin mayuscula?
    pass: 'yWH6vaD7pVqwrOxj'
  }
});

module.exports = transporter