// VER PERFIL CLIENTE - POST segun DNI ya obtenido traer el perfil de un cliente existente SE PODRIA HACER EN FRONT CON EL GET YA AGARRADO

// AGREGAR CLIENTE - POST con datos de cliente, chequear DNI no exista, agregar a BD

// VER LISTA CLIENTES - GET traer todos los clientes


// FILTRAR LISTA CLIENTES - POST con un DNI dado traer todos los matches

/*   buscas el num = 987
Pedro Gomez 40987867
Joaquin Gomez 41987867
Fafafa Gomez 42987867
Lautaro Gomez 30987867
*/

//  ELIMINAR CLIENTE - POST con un DNI dado eliminar la coincidencia

// EDITAR CLIENTE - POST con datos nuevos, chequear DNI 
                //DE PERMITIR CAMBIOS EN DNI, TABLAS FORANEAS???

const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();
const enviadorMails = require('./loginCheck.js');
const Log = require ('./admin.js')

//MEJOR MANERA ES HACER FUNCIONES DE BD Y FUNCIONES DE CONSULTAS POR SEPARADO Y QUE ESTAS INVOQUEN A LAS PRIMERAS
const getClientes = async () => {
    try {
        const resultado = await knex('cliente').select('*')
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    }
};

const getClientePorMail = async (mail) => {
    try {
        const resultado = await knex.select('*').from('cliente').where('MAIL', '=', mail)
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    } 
}

const getClientePorDNI= async (dni) => {
    try {
        const resultado = await knex.select('*').from('cliente').where('DNI', '=', dni).first()
        return resultado;
    } catch (error) {
        console.error(error)
        return false;
    } 
}

const addCliente = async (nuevoCliente) => {
    try {
        await knex('cliente').insert(nuevoCliente)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

// VER LISTA CLIENTES - GET traer todos los clientes
router.get('/getClientes', async (req, res) => {
    getClientes()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "VETERINARIO solicito clientes")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

router.post('/getCliente',async (req,res) =>{
    getClientePorDNI(req.body.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            console.log("\x1b[33m%s\x1b[0m", "SISTEMA solicito un cliente")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

router.post('/addCliente', async (req, res) => {
    enviadorMails.enviarMailPassword(req.body.cliente.mail)
    .then ((resultadoPassword) => {
        if (resultadoPassword !== false) {
            const nuevoCliente = {
                DNI: req.body.cliente.dni,
                NOMBREAPELLIDO: req.body.cliente.nombreApellido,
                MAIL: req.body.cliente.mail,
                TELEFONO: req.body.cliente.telefono,
                FECHAREGISTRO: new Date(),
                DIRECCION: req.body.cliente.direccion,
                PASSWORD: resultadoPassword,
            }
            addCliente(nuevoCliente)
            .then ((resultadoAdd) => {
                if (resultadoAdd !== false) {
                    // Log.agregarEntradaLog(req.body.token)
                    console.log("\x1b[35m%s\x1b[0m", `VETERINARIO registro al CLIENTE: ${req.body.cliente.nombreApellido}, DNI: ${req.body.cliente.dni}, Mail: ${req.body.cliente.mail}`)
                    res.status(200)
                } else {
                    res.status(401)
                }
            })
            .catch((error) => {
                console.error(error)
                res.status(401)
            })
        } else {
            res.status(401)
        }
    })
    .catch ((error) => {
        console.error(error)
        res.status(401)
    })
})

module.exports = router;