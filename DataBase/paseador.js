const express = require('express');
const knex = require ('./configs/knexConfig')

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
            console.log("\x1b[33m%s\x1b[0m", "USUARIO solicito paseadores")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

module.exports = router ;