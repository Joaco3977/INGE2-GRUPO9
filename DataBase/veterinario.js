// AGREGAR VETERINARIO - POST con datos de veterinario, chequear DNI no exista, agregar a BD

// ELIMINAR VETERINARIO - POST con DNI dado eliminar coincidencia en la BD

// EDITAR VETERINARIO - POST con datos nuevos, chequear DNI 
                //DE PERMITIR CAMBIOS EN DNI, TABLAS FORANEAS???

const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

const getVeterinarios = async () => {
    try {
        const resultado = await knex('veterinario').select('*').where('ELIMINADO', 0)
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const getVeterinarioPorDNI= async (dni) => {
    try {
        const resultado = await knex.select('*').from('veterinario').where('DNI', '=', dni).andWhere('ELIMINADO', 0).first()
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    } 
}

const addVeterinario = async (nuevoVeterinario) => {
    try {
        await knex('veterinario').insert(nuevoVeterinario)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

router.get('/getVeterinarios', async (req, res) => {
    getVeterinarios()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "ADMIN solicito veterinarios")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
});

router.post('/deleteVeterinario', async (req,res) =>{
    await knex('veterinario').where('DNI', req.body.dni).update('ELIMINADO', 1)
    await knex('turno').where('DNIVETERINARIO', req.body.dni).update('ELIMINADO', 1)
    .then(() =>{
        
        Consola.mensaje("\x1b[35m%s\x1b[0m",`ADMIN elimino veterinario ${req.body.nombre} con DNI: ${req.body.dni}`)
        Log.agregarEntradaLog(-1, '', '', `elimino al VETERINARIO ${req.body.dni}`)
        res.status(200).send({})
    }).catch((error)=>{
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/getVeterinario',async (req,res) =>{
    getVeterinarioPorDNI(req.body.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "SISTEMA solicito un Veterinario")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/getVeterinarioHistorial',async (req,res) =>{
    await knex('veterinario').select('*').where('DNI', req.body.dni).first()
    .then((response) => {
        res.status(200).send(response)
        Consola.mensaje("\x1b[33m%s\x1b[0m", "SISTEMA solicito un Veterinario")
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post ('/editarVeterinario',async(req,res)=>{
    try {  
        await knex('Veterinario').where("DNI", req.body.veterinario.dniA).update({"DNI":req.body.veterinario.dni,"NOMBREAPELLIDO" : req.body.veterinario.nombreApellido,"MAIL": req.body.veterinario.mail,"TELEFONO":req.body.veterinario.telefono});
        console.log("admin edito un vet")
        res.status(200).send({});
    }catch (error){
        console.log(error);
        res.status(401).send('No fue posible conectar con la base de datos');
    }
})

router.post('/addVeterinario', async (req,res)=>{
    enviadorMails.enviarMailPassword(req.body.veterinario.mail)
    .then((sendP)=>{
        if(sendP){
            let nuevoVeterinario = {
                DNI : req.body.veterinario.dni,
                NOMBREAPELLIDO : req.body.veterinario.nombreApellido,
                MAIL : req.body.veterinario.mail,
                TELEFONO : req.body.veterinario.telefono,
                PASSWORD : sendP,
                FECHAREGISTRO: new Date()
            }
            addVeterinario(nuevoVeterinario)
            .then((resultadoAdd)=>{
                if(resultadoAdd){
                    Consola.mensaje("\x1b[33m%s\x1b[0m", "ADMIN agrego un veterinario")
                    Log.agregarEntradaLog(-1, '', '', `agrego al VETERINARIO ${req.veterinario.nombreApellido} con DNI:${req.body.veterinario.dni}`)
                    res.status(200).send({})
                }else{
                    res.status(401)
                }
            }).catch(error => {
                console.log(error)
                res.status(401).send('No fue posible agregar al nuevo veterinario');
            })
        }else{
            res.status(401)
        }
    }).catch(error => {
        console.log(error)
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

module.exports = router;