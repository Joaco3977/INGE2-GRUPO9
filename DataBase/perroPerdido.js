const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

const getPerrosPerdidos = async () => {
    try {
        const resultado = await knex('perroPerdido').select('*').where('ELIMINADO', 0)
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const getPerrosPerdidosPropios = async (dni) =>{
    try {
        const resultado = await knex('perroPerdido').select('*').where('DNICLIENTE', dni).andWhere('ELIMINADO', 0)
        return resultado;
    }catch (error){
        console.error(error)
        return false;
    }
}

const addperroPerdido = async (nuevoPerroP) => {
    try {
        await knex('perroPerdido').insert(nuevoPerroP)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

// VER LISTA PERRO PERDIDOS - GET traer todos los perros perdidos
router.get('/getPerrosPerdidos', async (req, res) => {
    getPerrosPerdidos()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "Usuario solicito perros perdidos")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})
router.post('/getPerrosPerdidosPropios', async (req, res) => {
    await knex('perroPerdido').select('*').where('DNICLIENTE', req.body.dni).andWhere('ELIMINADO', 0)
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        console.log(error)
        res.status(401).send(error)
    })
})

router.post('/addPerroPerdido', async (req, res) => {
    console.log(req.body.perro)
            const nuevoPerroP = {
                SEXO: req.body.perro.sexo,
                TELEFONO:req.body.perro.telefono,
                NOMBRE:req.body.perro.nombre,
                ZONA: req.body.perro.zona,
                MAIL:req.body.perro.mail,
                COMENTARIO:req.body.perro.comentario,
                DNICLIENTE:req.body.dni,
                FECHAPERDIDA: new Date(req.body.perro.fechaPerdida)
            }
            addperroPerdido(nuevoPerroP)
            .then ((resultadoAdd) => {
                if (resultadoAdd !== false) {
                    //añadir a log
                    console.log("\x1b[35m%s\x1b[0m", `Cliente agrego al perro perdido: ${req.body.perro.nombre}`)
                    Log.agregarEntradaLog(req.body.rol, req.body.dni, `agrego al PERRO PERDIDO ${req.body.perro.nombre}`)
                    res.status(200).send({})
                } else {
                    res.status(401)
                }
            })
            .catch((error) => {
                console.error(error)
                res.status(401)
            })

    });

router.post('/marcarEncontrado', async(req,res) => {
        await knex('perroPerdido').where('IDPERROPERDIDO', req.body.id).update({ ENCONTRADO: 1 })
        .then(() => {
            Consola.mensaje("\x1b[35m%s\x1b[0m",`el perro con ID ${req.body.id} fue adoptado!`)
            res.status(200).send({});
        })
        .catch((error) => {
            console.log(error)
        })
})

router.post('/deletePerroPerdido', async (req,res) =>{
    let quien = ''
    if (req.body.rol === 1) {
        quien = 'CLIENTE'
    } else {
        quien = 'VETERINARIO'
    }
    knex('perroPerdido').where({
        DNICLIENTE: req.body.dnicliente,
        NOMBRE: req.body.nombre
    }).update('ELIMINADO', 1)
    .then(() =>{
        if (req.body.dni === req.body.dnicliente) {
            Log.agregarEntradaLog(req.body.rol, req.body.nombre, req.body.dni, `elimino a su propio PERRO PERDIDO ${req.body.nombre}`)
        } else {
            Log.agregarEntradaLog(req.body.rol, req.body.nombre, req.body.dni, `elimino al PERRO PERDIDO ${req.body.nombre} del cliente ${req.body.dnicliente}`)
        }
        res.status(200).send({})
    }).catch((error)=>{
        console.log(error)
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

    
module.exports = router;