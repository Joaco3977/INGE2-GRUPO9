const express = require("express");
const cors = require("cors");
const app = express().use(express.json());
const mysql = require("mysql2");

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

function login(mail, password) {
  const respuesta = {
    estado: false,
    nombre: "",
    rol: "",
  };
  //check admin, rol admin
  //check veterinario, rol vet
  return knex("cliente")
    .where({ mail, password })
    .select()
    .then((rows) => {
      if (rows.length > 0) {
        console.log(rows);
        respuesta.estado = true;
        respuesta.nombre = rows[0].NOMBREAPELLIDO;
        respuesta.mail = rows[0].MAIL;
        respuesta.rol = 3;
        return respuesta;
      } else {
        return respuesta;
      }
    })
    .catch((error) => {
      console.log(error);
      return respuesta;
    });
  return respuesta;
}

//Permite conexiones de cualquier origen
const corsOptions = {
  origin: "*",
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
};
app.use(cors(corsOptions));

app.post("/intentoLogin", (req, res) => {
  console.log(
    "\x1b[32m%s\x1b[0m",
    req.socket.remoteAddress,
    " esta intentando loguearse con: "
  );
  console.log(req.body);
  login(req.body.mail, req.body.password).then((resultado) => {
    if (resultado.estado) {
      let token = generarToken();
      console.log("\x1b[32m%s\x1b[0m", "se le asigna el token: ", token);
      console.log("\x1b[32m%s\x1b[0m", "sus credenciales son validas!");
      knex("token")
        .insert({
          mail: resultado.mail,
          token: token,
          rol: resultado.rol,
        })
        .then(() => {
          console.log("Registro insertado correctamente");
        })
        .catch((err) => {
          console.error(err);
        });
      res.status(200).send({ token: token, username: resultado.nombre });
    } else {
      console.log("\x1b[32m%s\x1b[0m", "sus credenciales no son validas!");
      res.status(401).send("Credenciales incorrectas");
    }
  });
});

app.post("/logout", (req, res) => {
  knex("token")
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
  knex("token")
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