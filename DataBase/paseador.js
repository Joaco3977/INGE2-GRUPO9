const express = require('express');
const knex = require ('./configs/knexConfig')
const Consola = require ('./serverFunctions.js')
const router = express.Router();
const enviadorMails = require('./loginCheck.js');
const Log = require ('./log.js')

const getPaseadores = async () => {
    try {
        const resultado = await knex('paseador').select('*').where('ELIMINADO', 0)
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const addPaseador = async (paseador) => {
    const nuevoPaseador = {
        DNI: paseador.dni,
        NOMBREAPELLIDO: paseador.nombre,
        MAIL: paseador.mail,
        ZONA: paseador.zona,
        DISPONIBILIDAD: paseador.disponibilidadJSON,
        TELEFONO: paseador.telefono,
        COMENTARIO: paseador.comentario,
    }
    try {
        await knex('paseador').insert(nuevoPaseador)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

router.get('/getPaseadores', async (req, res) => {
    getPaseadores()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "USUARIO solicito paseadores")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/addPaseador', async (req,res) => {
    const paseador = req.body.paseador;
    enviadorMails.enviarMail('Bienvenido nuevo Paseador!',`Hola ${paseador.nombre}, te comunicamos que ya estas registrado como paseador en OhMyDog!`, paseador.mail)
    .then((respuesta) => {
        if (respuesta) {
            addPaseador(paseador)
            .then((respuestaAdd) => {
                if (respuestaAdd) {
                    Log.agregarEntradaLog(2, req.body.nombreVet, req.body.dniVet, `agrego al PASEADOR ${req.body.dni}`)
                    Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO agrego paseador con dni: ${paseador.dni}`)
                    res.status(200).send({})
                } else {
                    res.status(401).send('No fue posible agregar al paseador a la base de datos')
                }
            })
            .catch((error) => {
                console.log(error)
                res.status(401).send('No fue posible conectar con la Base de Datos')
            })
        } else {
            res.status(401).send('No fue posible enviar el mail al paseador!')
        }
    })
    .catch(() => {
        res.status(401).send('No fue posible enviar el mail al paseador!')
    })
})

router.post('/editarPaseador', async (req,res) => {
    knex('paseador').where('DNI', req.body.dniAct).update({'DNI': req.body.paseador.DNI, 'NOMBREAPELLIDO': req.body.paseador.NOMBREAPELLIDO, "TELEFONO": req.body.paseador.TELEFONO, "MAIL": req.body.paseador.MAIL, "DISPONIBILIDAD": req.body.paseador.DISPONIBILIDAD, "ZONA": req.body.paseador.ZONA,"COMENTARIO":req.body.paseador.COMENTARIO})
    .then(() => {
        Log.agregarEntradaLog(2, req.body.nombreVet, req.body.dniVet, `edito al PASEADOR ${req.body.paseador.DNI}`)
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO edito al PASEADOR: ${req.body.paseador.DNI}`)
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/deletePaseador', async (req,res) =>{
    knex('paseador').where('DNI', req.body.dni).update('ELIMINADO', 1)
    .then(() =>{
        Log.agregarEntradaLog(2, req.body.nombreVet, req.body.dniVet, `elimino al PASEADOR ${req.body.dni}`)
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO elimino paseador con dni: ${req.body.dni}`)
        res.status(200).send({})
    }).catch(()=>{
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

module.exports = router ;