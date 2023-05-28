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

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

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
router.post('/getClientes', async (req, res) => {
    getClientes()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "VETERINARIO solicito clientes")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/getCliente',async (req,res) =>{
    getClientePorDNI(req.body.dni)
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401).send('No fue posible conectar con la base de datos');
        } else {
            Consola.mensaje("\x1b[33m%s\x1b[0m", "SISTEMA solicito un cliente")
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

router.post('/deleteCliente', async (req,res) =>{
    knex('cliente').where('DNI', req.body.dni).del()
    .then(() =>{
        Log.agregarEntradaLog(2, req.body.dniVet, `elimino al cliente ${req.body.dni}`)
        Consola.mensaje("\x1b[35m%s\x1b[0m",`VETERINARIO elimino cliente con dni: ${req.body.dni}`)
        res.status(200).send({})
    }).catch((error)=>{
        res.status(401).send('No fue posible conectar con la base de datos');
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
                    Log.agregarEntradaLog(2, req.body.dniVet, `registro al CLIENTE ${req.body.cliente.dni}`)
                    Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO registro al CLIENTE: ${req.body.cliente.nombreApellido}, DNI: ${req.body.cliente.dni}, Mail: ${req.body.cliente.mail}`)
                    res.status(200).send({})
                } else {
                    res.status(401).send('No se pudo insertar al nuevo cliente');
                }
            })
            .catch((error) => {
                console.error(error)
                res.status(401).send('No fue posible conectar con la base de datos');
            })
        } else {
            res.status(401).send('No fue posible conectar con la base de datos');
        }
    })
    .catch ((error) => {
        console.error(error)
        res.status(401).send('No fue posible conectar con la base de datos');
    })
})

module.exports = router;