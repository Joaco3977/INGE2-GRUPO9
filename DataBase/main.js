const express = require("express");
const cors = require("cors");
const app = express().use(express.json());
const mysql = require("mysql2");

const { checkAdmin } = require('./admin.js');
const { checkVeterinario } = require('./veterinario.js');
const { checkCliente } = require('./cliente.js');

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

const knex = require("knex")({
  client: "mysql2",
  connection: {
    host: "localhost",
    user: "root",
    password: "cg7ThKa8Bd@r5zyi",
    database: "ohmydog",
  },
});

//Permite conexiones de cualquier origen
const corsOptions = {
  origin: "*",
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
};
app.use(cors(corsOptions));

function generarToken() {
  let tamano = 32; /* ES MUCHO? */
  let resultado = "";
  const caracteres =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (let i = 0; i < tamano; i++) {
    resultado += caracteres.charAt(
      Math.floor(Math.random() * caracteres.length)
    );
  }

  return resultado;
}

app.post("/login", (req, res) => {
  console.log("\x1b[32m%s\x1b[0m",req.socket.remoteAddress," esta intentando loguearse con: ");
  console.log(req.body);
  let token = generarToken();
  if (checkAdmin(req.body.mail, req.body.password) != false) {
    console.log("\x1b[32m%s\x1b[0m", "ADMIN logueado! Se le asigna el token: ", token);
    res.status(200).send({ rol: -1 , token: token });
  } else {
    if (checkVeterinario(req.body.mail, req.body.password) != false) {
      console.log("\x1b[32m%s\x1b[0m", "VETERINARIO logueado! Se le asigna el token: ", token);
      res.status(200).send({ rol: 2 , token: token });
    } else {
      if (checkCliente(req.body.mail, req.body.password) != false ) {
        console.log("\x1b[32m%s\x1b[0m", "CLIENTE logueado! Se le asigna el token: ", token);
        res.status(200).send({ rol: 1 , token: token });
      } else {
        console.log("\x1b[32m%s\x1b[0m", "LAS CREDENCIALES NO COINCIDEN!");
        res.status(401).send({ rol: 0 });  //credenciales no validas!
      }
    }
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
    });
});

app.post("/pedirRol", (req, res) => {
  knex("sesion")
    .where({ token: req.body.token })
    .then((rows) => {
      if (rows.length > 0) {
        console.log("entre, rol: ", rows[0].rol);
        res.status(200).send({ rol: rows[0].rol });
      } else {
        res.status(401).send({ rol: 0 });
      }
    });
});

app.listen(5137, function () {
  console.log(
    "\x1b[36m%s\x1b[0m",
    "----------------------------------------------------------------------------"
  );
  console.log("\x1b[36m%s\x1b[0m", "Servidor Back iniciado en el puerto 5137");
});
