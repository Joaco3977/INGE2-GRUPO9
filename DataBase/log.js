const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')

const agregarEntradaLog = async (rol, dni, queHizo) => {
    let quien = ''
    if (rol === 1) {
        quien = 'CLIENTE'
    } else {
        if (rol === 2) {
            quien = 'VETERINARIO'
        } else {
            quien = 'ADMIN'
        }
    }
    const descripcion = `[${quien} ${dni}] -- ${queHizo}`
    await knex('log').insert({
        FECHA: new Date(),
        DESCRIPCION: descripcion
    })
}

router.get('/getLog', async (req,res) => {
    await knex('log').select('*')
    .then((response) => {
        res.status(200).send(response)
    })
    .catch((error) => {
        res.status(401).send('No se pudo acceder a la Base de Datos')
    })
})

module.exports = { agregarEntradaLog , router }