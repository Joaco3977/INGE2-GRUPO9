const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/pedirTurno', async (req, res) => {
    res.status(200).send({})
})

router.post('/crearTurno', async (req, res) => {
    res.status(200).send({})
})

router.post('/setEstado', async(req,res) =>{
    await knex('turno').where("ID",req.body.id).update({ ESTADO: req.body.state } )
    .then(()=>{
        Consola.mensaje("\x1b[33m%s\x1b[0m", `VETERINARIO cambio el estado del turno con id ${req.body.id}`)
        res.status(200).send({});
    }).catch((error)=>{
        console.log(error)
        res.status(401).send('No es posible realizar la operacion solicitada en este momento')
    })
})

router.post('/getTurnosDni', async (req, res) => {
    await knex('turno').select('*').where('DNICLIENTE', req.body.dni).andWhere('ESTADO', req.body.estado)
    .then ((resultado) => {
        Consola.mensaje("\x1b[33m%s\x1b[0m", `SISTEMA solicito turnos del cliente ${req.body.dni}`)
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send('No es posible realizar la operacion solicitada en este momento')
    })
})

router.post('/getTurnosEstado', async (req, res) => {
    await knex('turno').select('*').where('ESTADO', req.body.estado)
    .then ((resultado) => {
        Consola.mensaje("\x1b[33m%s\x1b[0m", `VETERINARIO solicito todos los turnos`)
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send('No es posible realizar la operacion solicitada en este momento')
    })
})

module.exports = router