// AGREGAR VETERINARIO - POST con datos de veterinario, chequear DNI no exista, agregar a BD

// ELIMINAR VETERINARIO - POST con DNI dado eliminar coincidencia en la BD

// EDITAR VETERINARIO - POST con datos nuevos, chequear DNI 
                //DE PERMITIR CAMBIOS EN DNI, TABLAS FORANEAS???

const express = require('express');
const knex = require('./configs/knexConfig.js');
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const getVeteriano = async () => {
    try {
        const resultado = await knex('veterinario').select('*')
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

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
    getVeteriano()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "Un ADMIN solicito veterinarios")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
});

router.post('/addVeterinario', async (req,res)=>{
    enviadorMails.enviarMailPassword(req.body.mail)
    .then((sendP)=>{
        if(sendP){
            let nuevoVeterinario = {
                DNI : req.body.veterinarioAgregar.DNI,
                NOMBREAPELLIDO : req.body.veterinarioAgregar.NOMBREAPELLIDO,
                MAIL : req.body.veterinarioAgregar.MAIL,
                PASSWORD : sendP,
            }
            addVeterinario(nuevoVeterinario)
            .then((resultadoAdd)=>{
                if(resultadoAdd){
                    console.log("\x1b[33m%s\x1b[0m", "Un ADMIN agrego un veterinario")
                    res.status(200)
                }else{
                    res.status(401)
                }
            }).catch(error => {
                console.log(error)
                res.status(401)
            })
        }else{
            res.status(401)
        }
    }).catch(error => {
        console.log(error)
        res.status(401)
    })
})

module.exports = router;