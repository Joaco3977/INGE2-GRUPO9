const express = require('express');
const knex = require ('./configs/knexConfig')
const Consola = require ('./serverFunctions.js')
const router = express.Router();

const getPaseadores = async () => {
    try {
        const resultado = await knex('paseador').select('*')
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

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
        res.status(401)
    })
})

router.post('/deletePaseador', async (req,res) =>{
    knex('paseador').where('DNI', req.body.dni).del()
    .then((resultado) =>{
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO elimino paseador con dni: ${req.body.dni}`)
        res.status(200).send({})
    }).catch((error)=>{
        res.status(401)
    })
})

module.exports = router ;