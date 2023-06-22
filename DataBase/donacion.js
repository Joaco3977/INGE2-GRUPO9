const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.get('/getDonaciones', (req,res) => {
    knex('campania').select('*').where('ELIMINADO', 0)
    .then ((response) => {
        Consola.mensaje("\x1b[33m%s\x1b[0m", "USUARIO solicito clientes")
        res.status(200).send(response)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({})
    })
})

router.post('/deleteDonacion', (req,res) => {
    knex('campania').where('ID', req.body.id).update('ELIMINADO', 1)
    .then(() => {
        Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO elimino la campaña con id: ${req.body.id}`);
        Log.agregarEntradaLog(req.body.quienSoy.rol, req.body.quienSoy.nombre, req.body.quienSoy.dni, `elimino la campaña ${req.body.nombre}`)
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({})
    })
})

router.post ('/editarDonacion',async(req,res)=>{
    try {  
        await knex('campania').where({
            NOMBRE: req.body.donacion.NOMBREA
        }).update({"NOMBRE" : req.body.donacion.NOMBRE,"MONTOESPERADO":req.body.donacion.MONTOESPERADO, "DESCRIPCION": req.body.donacion.DESCRIPCION});
        Log.agregarEntradaLog(2, req.body.quienSoy.nombre, req.body.quienSoy.dni, `edito la Donacion ${req.body.donacion.NOMBREA} `)
        res.status(200).send({});
    }catch (error){
        console.log(error);
        res.status(401).send('No fue posible conectar con la base de datos');
    }
})

router.post('/addDonacion', async (req,res) => {
    const nuevaCampania = {
        NOMBRE: req.body.campania.NOMBRE,
        DESCRIPCION: req.body.campania.DESCRIPCION,
        MONTOESPERADO: req.body.campania.MONTOESPERADO
    }
    await knex('campania').insert(nuevaCampania)
    .then(() => {
        Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO agrego la campaña: ${req.body.campania.NOMBRE}`)
        Log.agregarEntradaLog(req.body.quienSoy.rol, req.body.quienSoy.nombre, req.body.quienSoy.dni, `agrego la campaña ${nuevaDonacion.NOMBRE}`)
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({})
    })
})

router.post('/getMontoActual', async(req, res) => {
    await knex('donaciones')
    .sum('cantidad as total')
    .where('IDCAMPANIA', req.body.id)
    .then(result => {
      let total = result[0].total || 0
      res.status(200).send({total})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({total})
    })
})

router.post('/donar', async(req, res) => {
    let dniCliente = null
    if (req.body.dniCliente !== null) {
        dniCliente = req.body.dniCliente;
    } 
    const nuevaDonacion = {
        IDCAMPANIA: req.body.id,
        FECHA: new Date(),
        DNICLIENTE: dniCliente,
        CANTIDAD: req.body.cantidad,
    }
    await knex('donaciones').insert(nuevaDonacion)
    .then(() => {
        console.log("DONACION CORRECTA")
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/sumarBonus', async (req, res) => {
    await knex('cliente').where('DNI', req.body.dni).update({'MONTODESCUENTO': req.body.bonus})
    .then(() => {
        Consola.mensaje("\x1b[35m%s\x1b[0m", `CLIENTE ${req.body.dni} dono ${req.body.bonus / 0.10}$ pesos argentinos`)
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

module.exports = router;

