const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();

const Consola = require ('./serverFunctions.js')

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
        const resultado = await knex('perroAdopcion').select('*').where(perroAdopcion.DNI == dni) //esto mal
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
            Consola.mensaje("\x1b[33m%s\x1b[0m", "USUARIO solicito perros en adopcion")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/getPerrosAdopcionPropios', async (req, res) => {
    getPerrosAdopcionPropios(req.body.data.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "USUARIO solicito perros propios en adopcion")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
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
                DNICLIENTE:req.body.perro.dnicliente,
            }
            addperroAdopcion(nuevoPerroA)
            .then ((resultadoAdd) => {
                if (resultadoAdd !== false) {
                    //añadir a log
                    Consola.mensaje("\x1b[35m%s\x1b[0m", `CLIENTE agrego al perro en Adopcion: ${req.body.perro.nombre}`)
                    res.status(200)
                } else {
                    res.status(401).send('No fue posible agregar al perro en adopcion');
                }
            })
            .catch((error) => {
                console.error(error)
                res.status(401).send('No fue posible conectar con la base de datos');
            })

});

router.post('/deletePerroAdopcion', async (req,res) =>{
    console.log('req: ', req.body)
    let quien = ''
    if (req.body.rol === 1) {
        quien = 'CLIENTE'
    } else {
        quien = 'VETERINARIO'
    }
    knex('perroAdopcion').where({
        DNICLIENTE: req.body.dnicliente,
        NOMBRE: req.body.nombre
    }).del()
    .then(() =>{
        Consola.mensaje("\x1b[35m%s\x1b[0m",`${quien} ${req.body.dniQuien} elimino al perro en adopcion ${req.body.nombre} del cliente con DNI ${req.body.dnicliente}`)
        //iria a logs
        res.status(200).send({})
    }).catch(()=>{
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})


module.exports = router;