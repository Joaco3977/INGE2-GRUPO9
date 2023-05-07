const express = require("express");
const cors = require("cors");
const app = express().use(express.json());

const { checkAdmin } = require('./admin.js');
const { checkVeterinario } = require('./veterinario.js');
const { checkCliente } = require('./cliente.js');
const Sesion = require ('./sesion.js')

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

app.post("/login", async (req, res) => {
  const admin = checkAdmin(req.body.mail, req.body.password);
  const token = Sesion.generarToken();
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
                Sesion.almacenarToken(token, req.body.mail, 1);
                res.status(200).send({ rol: 1 , token: token });
              }
            });
        } else {
          console.log("\x1b[32m%s\x1b[0m", "VETERINARIO logueado! Se le asigna el token: ", token);
          Sesion.almacenarToken(token, req.body.mail, 2);
          res.status(200).send({ rol: 2 , token: token });
        }
      })
      .catch((error) => {
        console.error(`Error en una de las consultas: ${error.message}`);
      })
  } else {
    console.log("\x1b[32m%s\x1b[0m", "ADMIN logueado! Se le asigna el token: ", token);
    Sesion.almacenarToken(token, req.body.mail, -1);
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

app.post("/checkToken", async (req, res) => {
  try {
    const result = await Sesion.validarToken(req.body.token);
    res.status(200).send(result);
  } catch (error) {
    console.error(error);
    res.status(401);
  }
});

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