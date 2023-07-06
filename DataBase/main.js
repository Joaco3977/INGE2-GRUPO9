const express = require("express");
const cors = require("cors");
const app = express().use(express.json());
const knex = require ('./configs/knexConfig')
const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

const { checkAdmin, checkCliente, checkVeterinario } = require('./loginCheck.js');
const Sesion = require ('./sesion.js')

const transporter = require ('./configs/mailConfig.js')

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


const clienteRouter = require ('./cliente.js')
const veterinarioRouter = require ('./veterinario.js')
const adminRouter = require ('./admin.js')
const perroAdopcionRouter = require ('./perroAdopcion.js')
const perroPerdidoRouter = require ('./perroPerdido.js')
const perroRouter = require ('./perro.js')
const paseadorRouter = require ('./paseador.js')
const turnoRouter = require ('./turno.js');
const donacionRouter = require ('./donacion.js');
const logRouter = Log.router;
const historialRouter = require ('./historial.js');
const cruzaRouter = require ('./cruza.js')

app.use('/cliente', clienteRouter)
app.use('/veterinario', veterinarioRouter)
app.use('/admin', adminRouter)
app.use('/perroAdopcion', perroAdopcionRouter)
app.use('/perroPerdido', perroPerdidoRouter)
app.use('/perro', perroRouter)
app.use('/paseador', paseadorRouter)
app.use('/turno', turnoRouter)
app.use('/donacion', donacionRouter)
app.use('/log', logRouter)
app.use('/historial', historialRouter)
app.use('/cruza', cruzaRouter)

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
                Consola.mensaje("\x1b[36m%s\x1b[0m", "LAS CREDENCIALES NO COINCIDEN!");
                res.status(401).send({ rol: 0 });
              } else {
                Consola.mensaje("\x1b[36m%s\x1b[0m", `CLIENTE ${resultCli.NOMBREAPELLIDO} logueado! Se le asigna el token: ${token}`);
                Sesion.almacenarToken(token, req.body.mail, resultCli.DNI , 1);
                res.status(200).send({ rol: 1 , token: token , dni: resultCli.DNI , nombre: resultCli.NOMBREAPELLIDO});
              }
            })
            .catch(() => {
              res.status(401).send('No fue posible conectar con la base de datos')
            })
        } else {
          Consola.mensaje("\x1b[36m%s\x1b[0m", `VETERINARIO ${resultVet.NOMBREAPELLIDO} logueado! Se le asigna el token: ${token}`);
          Sesion.almacenarToken(token, req.body.mail, resultVet.DNI, 2);
          res.status(200).send({ rol: 2 , token: token , dni: resultVet.DNI , nombre: resultVet.NOMBREAPELLIDO});
        }
      })
      .catch(() => {
        res.status(401).send('No fue posible conectar con la base de datos');
      })
  } else {
    Consola.mensaje("\x1b[36m%s\x1b[0m", `ADMIN logueado! Se le asigna el token: ${token}`)
    Sesion.almacenarToken(token, req.body.mail, -1 , -1);
    res.status(200).send({ rol: -1 , token: token });
  }
});

app.post("/passwordCheck", async (req, res) => {
  console.log(req.body)
    checkVeterinario(req.body.mail, req.body.password)
      .then((resultVet) => {
        if (resultVet === false) {
          return checkCliente(req.body.mail, req.body.password)
            .then((resultCli) => {
              if (resultCli === false) {
                console.log("Chequeo incorrecto")
                res.status(401).send({ check:false });
              } else {
                console.log("Chequeo correcto de contraseña para cliente")
                res.status(200).send({ check:true });
              }
            })
            .catch(() => {
              res.status(401).send('No fue posible conectar con la base de datos')
            })
        } else {
          console.log("Chequeo correcto de contraseña para Veterinario")
          res.status(200).send({ check:true });
        }
      })
      .catch(() => {
        res.status(401).send('No fue posible conectar con la base de datos');
      })
});


  app.post("/cambiarContraseniaVet", async (req, res) => {
    knex("veterinario").where("MAIL", req.body.mail).update({PASSWORD : req.body.password})
    .then((response)=>{
      console.log("se cambio con exito la contraseña del veterinario con mail:", req.body.mail)
      res.status(200).send({});
    }).catch((error)=>{
      console.log(error)
      res.status(401).send({});
    })
  });

  app.post("/cambiarContraseniaCli", async (req, res) => {
    knex("cliente").where("MAIL", req.body.mail).update({PASSWORD : req.body.password})
    .then(()=>{
      console.log("se cambio con exito la contraseña del cliente con mail:", req.body.mail)
      res.status(200).send({});
    }).catch((error)=>{
      console.log(error)
      res.status(401).send({});
    })
  }); 

app.post("/logout", async (req, res) => {
  try {
    const result = await Sesion.eliminarToken(req.body.token)
    res.status(200).send(result)
  } catch {
    console.error(error)
    res.status(401).send('No fue posible conectar con la base de datos');
  }
});

app.post("/checkToken", async (req, res) => {
  try {
    const result = await Sesion.validarToken(req.body.token);
    res.status(200).send(result);
  } catch (error) {
    console.error(error);
    res.status(401).send('No fue posible conectar con la base de datos');
  }
});

app.listen(5137, function () {
  Consola.mensaje("\x1b[32m%s\x1b[0m","----------------------------------------------------------------------------");
  Consola.mensaje("\x1b[32m%s\x1b[0m", "Servidor BD iniciado en el puerto 5137");
  transporter.verify(function (error, success) {
    if (error) {
      Consola.mensaje("\x1b[31m%s\x1b[0m",'------------------------------------------------')
      console.log(error);
    } else {
      Consola.mensaje("\x1b[32m%s\x1b[0m", "Servidor de Mail esta listo para enviar correos!");
    }
  });
});

process.on('SIGINT', async () => {
  await Sesion.limpiarTokens()
  Consola.mensaje("\x1b[31m%s\x1b[0m", "Servidor BD cerrado con CTRL + C");
  Consola.mensaje("\x1b[31m%s\x1b[0m", "----------------------------------------------------------------------------");
  process.exit()
})

process.on('exit', async () => {
  await Sesion.limpiarTokens()
  Consola.mensaje("\x1b[31m%s\x1b[0m", "Servidor BD cerrado inesperadamente!");
  Consola.mensaje("\x1b[31m%s\x1b[0m", "----------------------------------------------------------------------------");
  process.exit()
})