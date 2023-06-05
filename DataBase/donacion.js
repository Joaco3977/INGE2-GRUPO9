const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.get('/getDonaciones', (req,res) => {
    knex('campania').select('*')
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
    knex('campania').where('NOMBRE', req.body.nombre).del()
    .then(() => {
        res.status(200).send({})
        Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO elimino la campaña: ${req.body.campania.NOMBRE}`);
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({})
    })
})

router.post('/addDonacion', (req,res) => {
    knex('campania').insert(req.body.campania)
    .then(() => {
        res.status(200).send({})
        Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO agrego la campaña: ${req.body.campania.NOMBRE}`)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send({})
    })
})

module.exports = router;
