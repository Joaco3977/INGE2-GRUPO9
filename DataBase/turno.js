const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/pedirTurno', async (req, res) => {
    await knex('turno').insert(req.body.turno)
    .then(() => {
        const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
        const mensaje = `Hola ${req.body.turno.NOMBRECLIENTE}, te informamos que el turno de ${req.body.turno.NOMBRESERVICIO} para su perro ${req.body.turno.NOMBREPERRO}, en la fecha ${(new Date(req.body.turno.FECHA)).toLocaleDateString('es-ES', opciones)} fue solicitado con exito!`
        enviadorMails.enviarMail('Turno Solicitado', mensaje , req.body.mail)
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
        const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
        var mensaje = " ";
        knex('turno').where("ID",req.body.id).first()
        .then((turno)=>{
            knex('cliente').select('MAIL').where('DNI', turno.DNICLIENTE).first()
            .then((mail) =>{
                if(req.body.rol === 2){
                    if(turno.FRANJAHORARIA === null){
                        mensaje=`Hola ${turno.NOMBRECLIENTE}! El turno solicitado de ${turno.NOMBRESERVICIO} para su perro ${turno.NOMBREPERRO}, para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)}, fue rechazado por un veterinario.`
                        enviadorMails.enviarMail('Turno rechazado', mensaje , mail.MAIL)
                    }else{
                        mensaje=`Hola ${turno.NOMBRECLIENTE}! Lo sentimos mucho pero el turno confirmado de ${turno.NOMBRESERVICIO} para su perro ${turno.NOMBREPERRO}, para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)}, fue cancelado por un veterinario.`
                        enviadorMails.enviarMail('Turno cancelado por la veterinaria', mensaje , mail.MAIL)
                    }
                }else{
                    if(turno.FRANJAHORARIA === null){
                        mensaje=`Hola ${turno.NOMBRECLIENTE}! Le informamos que el turno solicitado de ${turno.NOMBRESERVICIO} para su perro ${turno.NOMBREPERRO}, para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)}, fue cancelado con exito.`
                        enviadorMails.enviarMail('Turno cancelado con exito', mensaje , mail.MAIL)
                    }else{
                        knex('veterinario').select('MAIL').where('DNI',turno.DNIVETERINARIO).first()
                        .then((mailVet)=>{
                            mensaje=`Hola ${turno.NOMBRECLIENTE}! Le informamos que el turno confirmado de ${turno.NOMBRESERVICIO} para su perro ${turno.NOMBREPERRO}, para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)}, fue cancelado con exito.`
                            enviadorMails.enviarMail('Turno cancelado con exito', mensaje , mail.MAIL)
                            mensaje=`Hola ${turno.NOMBREVETERINARIO}! Le informamos que el turno que habia sido confirmado de ${turno.NOMBRESERVICIO} para el perro ${turno.NOMBREPERRO} del cliente con DNI ${turno.DNICLIENTE}, para el dia ${turno.FECHA.toLocaleDateString('es-ES', opciones)} por la ${turno.FRANJAHORARIA} , fue cancelado por el cliente.`
                            enviadorMails.enviarMail('Turno cancelado por cliente', mensaje , mailVet.MAIL)
                        })
                        .catch((err)=>{
                            console.log(err)
                        })
                    }
                }
            })
        })
        .catch((error) => {
            console.log(error)
        })
        Consola.mensaje("\x1b[33m%s\x1b[0m", `se cancelo el turno con id ${req.body.id}`)
        Log.agregarEntradaLog(req.body.rol, )
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
    await knex('turno').select('*').where('DNICLIENTE', req.body.dni).andWhere('ESTADO', req.body.estado).andWhere("ELIMINADO", 0)
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
    await knex('turno').select('*').where('ESTADO', req.body.estado).andWhere("ELIMINADO", 0)
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