const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/getHistorial', async (req,res) => {
    await knex('historialperro').where('IDPERRO', req.body.id)
    .then((response) => {
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO solicito historial del perro ${req.body.id}`)
        res.status(200).send(response)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send([])
    })
})

router.post('/agregarEntrada', async (req,res) => {
    let nuevaEntrada = {
        IDPERRO: req.body.entrada.IDPERRO,
        DNIVET: req.body.entrada.DNIVET,
        FECHA: new Date(),
        NOMBRESERVICIO: req.body.entrada.NOMBRESERVICIO,
        COMENTARIO: req.body.entrada.COMENTARIO,
        NOMBREVACUNA: req.body.entrada.NOMBREVACUNA
    }
    await knex('historialperro').insert(nuevaEntrada)
    .then(() => {
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

module.exports = router