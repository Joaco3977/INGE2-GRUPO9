const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const getPerrosPerdidos = async () => {
    try {
        const resultado = await knex('perroPerdido').select('*')
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const getPerrosPerdidosPropios = async (dni) =>{
    try {
        const resultado = await knex('perroPerdido').select('*').where(perroPerdido.DNI == dni)
        return resultado;
    }catch (error){
        console.error(error)
        return false;
    }
}

const addperroPerdido = async (nuevoPerroP) => {
    try {
        await knex('perroAdopcion').insert(nuevoPerroP)
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
    getPerrosPerdidosPropios(req.body.data.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "Usuario solicito perros propios perdidos")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

router.post('/addPerroPerdido', async (req, res) => {
            const nuevoPerroP = {
                FOTO:req.bodu.perro.foto,
                TAMANIO:req.body.perro.tamanio,
                EDAD:req.body.perro.edad,
                TELEFONO:req.body.perro.telefono,
                NOMBRE:req.body.perro.nombre,
                MAIL:req.body.perro.mail,
                COMENTARIO:req.body.perro.comentario,
                DNI:req.body.perro.dni,
            }
            addperroAdopcion(nuevoPerroP)
            .then ((resultadoAdd) => {
                if (resultadoAdd !== false) {
                    //añadir a log
                    console.log("\x1b[35m%s\x1b[0m", `Cliente agrego al perro perdido: ${req.body.perro.nombre}`)
                    res.status(200)
                } else {
                    res.status(401)
                }
            })
            .catch((error) => {
                console.error(error)
                res.status(401)
            })

    });

    
module.exports = router;