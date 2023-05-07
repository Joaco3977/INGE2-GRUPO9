const express = require("express");
const cors = require("cors");
const app = express().use(express.json());

const { checkAdmin } = require('./admin.js');
const { checkVeterinario } = require('./veterinario.js');
const { checkCliente } = require('./cliente.js');

const knex = require('../OhMyDog/src/db/knexConfig.js')

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

//Permite conexiones de cualquier origen
const corsOptions = {
  origin: "*",
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
};
app.use(cors(corsOptions));

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

app.post("/login", async (req, res) => {
  const admin = checkAdmin(req.body.mail, req.body.password);
  const token = generarToken();
  if (admin === false) {
    checkVeterinario(req.body.mail, req.body.password)
      .then((resultVet) => {
        if (resultVet === false) {
          return checkCliente(req.body.mail, req.body.password)
            .then((resultCli) => {
              if (resultCli === false) {
                console.log("\x1b[32m%s\x1b[0m", "LAS CREDENCIALES NO COINCIDEN!");
                res.status(401).send({ rol: 0 });
              } else {
                console.log("\x1b[32m%s\x1b[0m", "CLIENTE logueado! Se le asigna el token: ", token);
                almacenarToken(token, req.body.mail, 1);
                res.status(200).send({ rol: 1 , token: token });
              }
            });
        } else {
          console.log("\x1b[32m%s\x1b[0m", "VETERINARIO logueado! Se le asigna el token: ", token);
          almacenarToken(token, req.body.mail, 2);
          res.status(200).send({ rol: 2 , token: token });
        }
      })
      .catch((error) => {
        console.error(`Error en una de las consultas: ${error.message}`);
      })
  } else {
    console.log("\x1b[32m%s\x1b[0m", "ADMIN logueado! Se le asigna el token: ", token);
    almacenarToken(token, req.body.mail, -1);
    res.status(200).send({ rol: -1 , token: token });
  }
});

app.post("/logout", (req, res) => {
  knex("sesion")
    .where({ token: req.body.token })
    .del()
    .then(function (rowsDeleted) {
      console.log("Rows deleted: " + rowsDeleted);
      res.status(200).send("Sesion cerrada con exito!");
    })
    .catch(function (error) {
      console.error(error);
      res.status(404).send("No se encontro esa sesion");
    })
});

/*
app.post("/checkToken", async (req, res) => {
  await knex('sesion').select('*').where('TOKEN', '=', req.body.token).first()
  .then ((resultado) => {
    if (resultado === false) {
      res.status(401).send({ rol: 0 , tab : 'Iniciar Sesion' })
    } else {
      res.status(200).send({ rol: resultado.ROL })
    }
  })
  .catch ((error) => {
    console.error(error)
    res.status(401).send({ rol: 0 , tab : 'Iniciar Sesion' })
  })
});
*/

const validarToken = async (token) => {
  await knex('sesion').select('*').where('TOKEN', '=', token).first()
  .then ((resultado) => {
    if (resultado === false) {
      return ({ rol: 0 , tab : 'Iniciar Sesion' })
    } else {
      return ({ rol: resultado.ROL })
    }
  })
  .catch ((error) => {
    console.error(error)
    return ({ rol: 0 , tab : 'Iniciar Sesion' })
  })
}

/*
app.post("/checkToken", async (req, res) => {
  const respuestaToken = validarToken(req.headers.aut)
  res.send(respuestaToken)
})
*/

app.listen(5137, function () {
  console.log("\x1b[36m%s\x1b[0m","----------------------------------------------------------------------------");
  console.log("\x1b[36m%s\x1b[0m", "Servidor Back iniciado en el puerto 5137");
});

process.on('exit', () => {
  knex.destroy()
  console.log('Servidor web apagado, o colapso!')
})

/*
process.on('SIGTERM', () => {
  server.close(() => {
    knex.destroy()
    console.log('Servidor web apagado')
  })
})

process.on('SIGINT', () => {
  server.close(() => {
    knex.destroy()
    console.log('Servidor web apagado')
  })
})
*/