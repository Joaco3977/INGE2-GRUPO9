const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/pedirTurno', async (req, res) => {
    await knex('turno').insert(req.body.turno)
    .then(() => {
        Consola.mensaje("\x1b[33m%s\x1b[0m", `cliente ${req.body.turno.NOMBRECLIENTE} pidio un turno`)
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/cancelarTurno', async(req,res) =>{
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
    await knex('turno').where("ID",req.body.id).update({ ESTADO: 'Confirmado' , FRANJAHORARIA: req.body.franjaHoraria, NOMBREVETERINARIO: req.body.nombre, DNIVETERINARIO: req.body.dni} )
    .then(()=>{
        knex('cliente').select('MAIL').where('DNI', req.body.dniCliente).first()
        .then((mail) => {
            knex('turno').where("ID",req.body.id).first()
            .then ((turno) => {
                const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
                const mensaje = `Hola ${turno.NOMBRECLIENTE}, se le informa que el turno solicitado de ${turno.NOMBRESERVICIO} para su perro ${turno.NOMBREPERRO} fue confirmado por el veterinario ${turno.NOMBREVETERINARIO}.
                El turno esta asignado para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)} por la ${req.body.franjaHoraria}`
                enviadorMails.enviarMail('Turno confirmado', mensaje , mail.MAIL)
                Consola.mensaje("\x1b[33m%s\x1b[0m", `${turno.NOMBREVETERINARIO} confirmo el turno con id ${req.body.id} para el perro ${turno.NOMBREPERRO}`)
                res.status(200).send({});
            })
        })
        .catch((error) => {
            console.log(error)
        })
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