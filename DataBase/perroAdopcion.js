const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const getPerrosAdopcion = async () => {
    try {
        const resultado = await knex('perroAdopcion').select('*')
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const getPerrosAdopcionPropios = async (dni) =>{
    try {
        const resultado = await knex('perroAdopcion').select('*').where(perroAdopcion.DNI == dni)
        return resultado;
    }catch (error){
        console.error(error)
        return false;
    }
}

const addperroAdopcion = async (nuevoPerroA) => {
    try {
        await knex('perroAdopcion').insert(nuevoPerroA)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

// VER LISTA PERRO ADOPCION - GET traer todos los perros adopcion
router.get('/getPerrosAdopcion', async (req, res) => {
    getPerrosAdopcion()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "Usuario solicito perros en adopcion")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

router.post('/getPerrosAdopcionPropios', async (req, res) => {
    getPerrosAdopcionPropios(req.body.data.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "Usuario solicito perros propios en adopcion")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})


router.post('/addPerroAdopcion', async (req, res) => {

            const nuevoPerroA = {
                SEXO:req.body.perro.sexo,
                TAMANIO:req.body.perro.tamanio,
                EDAD:req.body.perro.edad,
                TELEFONO:req.body.perro.telefono,
                NOMBRE:req.body.perro.nombre,
                MAIL:req.body.perro.mail,
                COMENTARIO:req.body.perro.comentario,
                DNI:req.body.perro.dni,
            }
            addperroAdopcion(nuevoPerroA)
            .then ((resultadoAdd) => {
                if (resultadoAdd !== false) {
                    //añadir a log
                    console.log("\x1b[35m%s\x1b[0m", `Cliente agrego al perro en Adopcion: ${req.body.perro.nombre}`)
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