// VER LISTA DE PERROS de CLIENTE - POST segun DNI de cliente dado, traer todas las coincidencias de esos perros con ese DNI

// AGREGAR PERRO - POST segun DNI de cliente dado, y datos de perro dados, NO PUEDE HABER NOMBRE IGUAL YA REGISTRADO PARA ESE CLIENTE, agregar perro a BD

// ELIMINAR PERRO - POST segun DNI de cliente y NOMBRE de perro, borrar ese perro de ese cliente de BD

// VER LISTA DE ENTRADAS DE HISTORIAL MEDICO - POST segun DNI de cliente y NOMBRE de perro, traer de BD las entradas de historial medico de ese perro

// AGREGAR ENTRADA DE HISTORIAL - POST segun FK id del perro dado, agregar a LISTA DE ENTRADAS DEL HISTORIAL MEDICO, una nueva ENTRADA con los datos brindados y ese id

const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

const rutaFoto = require ('./configs/rutaFotosConfig.js')

const getPerrosPropios = async (dni) => {
    try {
        const resultado = await knex('perro').select('*').where('DNICLIENTE', dni).andWhere('ELIMINADO', 0)
        return resultado;
    }catch (error){
        console.error(error)
        return false;
    }
}
const addPerro = async (nuevoPerro) => {
    try {
        await knex('perro').insert(nuevoPerro)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}


router.post('/getPerrosPropios', async (req, res) => {
    getPerrosPropios(req.body.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "USUARIO solicito perros propios")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/addPerro', async (req, res) => {
    const nuevoPerro = {
        SEXO:req.body.perro.sexo,
        TAMANIO:req.body.perro.tamanio,
        NACIMIENTO:req.body.perro.nacimiento,
        RAZA:req.body.perro.raza,
        NOMBRE:req.body.perro.nombre,
        PESO:req.body.perro.peso,
        COLOR:req.body.perro.color,
        DNICLIENTE:req.body.perro.dnicliente,
    }
    addPerro(nuevoPerro)
    .then ((resultadoAdd) => {
        if (resultadoAdd !== false) {
            Log.agregarEntradaLog(2, req.body.quienSoy.nombre, req.body.quienSoy.dni, `agrego al PERRO ${req.body.perro.nombre} del cliente con DNI:${req.body.perro.dnicliente}`)
            Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO agrego al perro: ${req.body.perro.nombre} al cliente con dni ${req.body.perro.dnicliente}`)
            res.status(200).send({})
        } else {
            res.status(401).send('No fue posible agregar al perro');
        }
    })
    .catch((error) => {
        console.error(error)
        res.status(401).send('No fue posible conectar con la base de datos');
    })

});

router.post('/getFoto', async(req,res)=> {
    const imgPath = `${rutaFoto()}/imagenes/PERRO/${req.body.id}.png`
    res.status(200).sendFile(imgPath)
})

router.post ('/editarPerro',async(req,res)=>{
    try {  
        const opciones = { year: 'numeric', month: 'long', day: 'numeric' };
        await knex('perro').where({
            DNICLIENTE: req.body.perro.dnicliente,
            NOMBRE: req.body.perro.nombreA
        }).update({"NOMBRE" : req.body.perro.nombre,"TAMANIO": req.body.perro.tamanio,"NACIMIENTO":(new Date(req.body.perro.nacimiento)),"SEXO": req.body.perro.sexo, "COLOR" : req.body.perro.color, "RAZA": req.body.perro.raza, "PESO" : req.body.perro.peso});
        Log.agregarEntradaLog(2, req.body.quienSoy.nombre, req.body.quienSoy.dni, `edito al PERRO ${req.body.perro.nombre} del CLIENTE con DNI: ${req.body.perro.dnicliente}`)
        res.status(200).send({});
    }catch (error){
        console.log(error);
        res.status(401).send('No fue posible conectar con la base de datos');
    }
})

router.post('/deletePerroPropio', async (req, res) => {
    knex('perro').where({
        DNICLIENTE: req.body.perro.dnicliente,
        NOMBRE: req.body.perro.nombre
    }).update('ELIMINADO', 1)
    .then(() =>{
        knex('turno').where('DNICLIENTE', req.body.perro.dnicliente).andWhere('NOMBREPERRO', req.body.perro.nombre).update('ELIMINADO', 1)
        .then(() => {
            Consola.mensaje("\x1b[35m%s\x1b[0m",`CLIENTE ${req.body.perro.dnicliente} elimino a su perro: ${req.body.perro.nombre}`)
        if (req.body.perro.dnicliente === req.body.quienSoy.dni) {
            Log.agregarEntradaLog(1, req.body.quienSoy.nombre, req.body.quienSoy.dni, `elimino a su propio PERRO ${req.body.perro.nombre}`)
        } else {
            Log.agregarEntradaLog(2, req.body.quienSoy.nombre, req.body.quienSoy.dni, `elimino al PERRO ${req.body.perro.nombre} del cliente con DNI:${req.body.perro.dnicliente}`)
        }
        res.status(200).send({})
        })
        .catch((error) => {
            console.log(error)
            res.status(401).send(error)
        })
    }).catch((error)=>{
        console.log(error)
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

module.exports = router;