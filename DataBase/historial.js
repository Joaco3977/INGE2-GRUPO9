const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/getHistorial', async (req,res) => {
    await knex('historial').where('IDPERRO', req.body.id)
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
    res.status(200).send({})
})

module.exports = router