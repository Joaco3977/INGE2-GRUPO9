const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

router.post('/loadMisDisponiblesCruzar', async (req, res) => {
    await knex('perro').select('*').where('ELIMINADO', 0).andWhere('DNICLIENTE', req.body.dni).andWhere('CRUZA', 0)
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/loadMisPerrosEnCruza', async (req, res) => {
    await knex('perro').select('*').where('ELIMINADO', 0).andWhere('DNICLIENTE', req.body.dni).andWhere('CRUZA', 1)
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/getPerrosCruza', async (req,res) => {
    await knex('perro').select('*').where('ELIMINADO', 0).andWhere('DNICLIENTE', '!=', req.body.dni).andWhere('CRUZA', 1)
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/getPerrosRecomendados', async (req,res) => {
    await knex('perro').select('*').where('ELIMINADO', 0).andWhere('DNICLIENTE', '!=', req.body.dni).andWhere('CRUZA', 1).andWhere('RAZA', req.body.raza).andWhere('SEXO', '!=', req.body.sexo)
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/addPerroCruza', async (req,res) => {
    await knex('perro').select('*').where('ID', req.body.id).update({'CRUZA' : 1})
    .then(() => {
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/getNumeroDuenio', async (req,res) => {
    await knex('cliente').select('TELEFONO').where('DNI', req.body.dni).first()
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})
module.exports = router