 // VER LOG - GET traer todos las entradas

 // FILTRAR LOG - seria interno en JS, con el GET ya dado de arriba, puesto q no podemos filtrar por string en BD  Ó  con filtro Like en BD.

const express = require('express');
const knex = require ('./configs/knexConfig')

const router = express.Router();

router.get('/getLog', async (req, res) => {
    knex('log').select('*')
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        res.status(401).send('No fue posible conectar a la Base de Datos')
        console.error(error)
    })
})

module.exports = router ; //agregarEntradaLog