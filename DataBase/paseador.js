const express = require('express');
const knex = require ('./configs/knexConfig')
const Consola = require ('./serverFunctions.js')
const router = express.Router();
const enviadorMails = require('./loginCheck.js');
const Mail = require('nodemailer/lib/mailer');

const getPaseadores = async () => {
    try {
        const resultado = await knex('paseador').select('*')
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
    console.log(paseador)
    enviadorMails.enviarMailPaseador(paseador.nombre, paseador.mail)
    .then((respuesta) => {
        if (respuesta) {
            addPaseador(paseador)
            .then((respuestaAdd) => {
                if (respuestaAdd) {
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

router.post('/deletePaseador', async (req,res) =>{
    knex('paseador').where('DNI', req.body.dni).del()
    .then(() =>{
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO elimino paseador con dni: ${req.body.dni}`)
        res.status(200).send({})
    }).catch(()=>{
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

module.exports = router ;