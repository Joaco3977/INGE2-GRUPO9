const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

router.post('/editarVeterinaria', async(req,res) => {

})

router.post('/registrarVeterinariaRegistrada', async(req,res) => {
    const nuevaVet = {
        NOMBRE: req.body.veterinaria.nombre,
        DIRECCION: req.body.veterinaria.direccion
    }
    await knex('veterinaria').insert(nuevaVet)
    .then(() => {
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/agregarVeterinariaListado', async(req, res) => {
    const nuevaVet = {
        NOMBRE: req.body.veterinaria.nombre,
        DIRECCION: req.body.veterinaria.direccion,
        FECHA: new Date(req.body.veterinaria.fecha),
    }
    await knex('listadovetsturno').insert(nuevaVet)
    .then(() => {
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/eliminarVeterinariaRegistrada', async(req,res) => {
    await knex('veterinaria').where('ID', req.body.id).del()
    .then(() => {
        console.log('Se elimino una vet')
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/eliminarVeterinariaListado', async(req,res) => {
    await knex('listadovetsturno').where('ID', req.body.id).del()
    .then(() => {
        console.log('Se elimino una vet')
        res.status(200).send({})
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.get('/getVetsRegistradas', async(req,res) => {
    await knex('veterinaria').select('*')
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.get('/getListadoVetsTurno', async(req,res) => {
    await knex('listadovetsturno').select('*')
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

module.exports = router