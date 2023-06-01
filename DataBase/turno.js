const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/pedirTurno', async (req, res) => {
    try {
        await knex('turno').insert()
        return true
    } catch (error) {
        console.error(error)
        return false
    }
})

router.post('/cancelarTurno', async(req,res) =>{
    console.log(req.body)
    await knex('turno').where("ID",req.body.id).update({ ESTADO: 'Cancelado' } )
    .then(()=>{
        Consola.mensaje("\x1b[33m%s\x1b[0m", `se cancelo el turno con id ${req.body.id}`)
        res.status(200).send({});
    }).catch((error)=>{
        console.log(error)
        res.status(401).send('No es posible realizar la operacion solicitada en este momento')
    })
})

router.post('/confirmarTurno', async(req,res) =>{
    await knex('turno').where("ID",req.body.id).update({ ESTADO: 'Confirmado' , FRANJAHORARIA: req.body.franjaHoraria} )
    .then(()=>{
        Consola.mensaje("\x1b[33m%s\x1b[0m", `se confirmo el turno con id ${req.body.id}`)
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