const express = require('express');
const knex = require('./configs/knexConfig.js')
const router = express.Router();
const enviadorMails = require('./loginCheck.js');

const Consola = require ('./serverFunctions.js')
const Log = require ('./log.js')

const getClientes = async () => {
    try {
        const resultado = await knex('cliente').select('*').where('ELIMINADO', 0).orderBy('FECHAREGISTRO', 'desc');
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
        const resultado = await knex.select('*').from('cliente').where('DNI', dni).andWhere('ELIMINADO', 0).first()
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

router.post('/deleteCliente', async (req, res) => {
    try {
        await knex('perro').where('DNICLIENTE', req.body.dni).update('ELIMINADO', 1);
        await knex('turno').where('DNICLIENTE', req.body.dni).update('ELIMINADO', 1);
      await knex('cliente').where('DNI', req.body.dni).update('ELIMINADO', 1)
      Log.agregarEntradaLog(2, req.body.dniVet, `elimino al cliente ${req.body.dni}`);
      Consola.mensaje("\x1b[35m%s\x1b[0m", `VETERINARIO elimino cliente con dni: ${req.body.dni} junto con todos sus perros`);
      res.status(200).send({});
    } catch (error) {
      console.log(error);
      res.status(401).send('No fue posible conectar con la base de datos');
    }
});
  

router.post ('/editarCliente',async(req,res)=>{
    try {  
        await knex('cliente').where("DNI", req.body.cliente.dniA).update({"DNI":req.body.cliente.dni,"NOMBREAPELLIDO" : req.body.cliente.nombreApellido,"MAIL": req.body.cliente.mail,"TELEFONO":req.body.cliente.telefono,"DIRECCION": req.body.cliente.direccion});
        res.status(200).send({});
    }catch (error){
        console.log(error);
        res.status(401).send('No fue posible conectar con la base de datos');
    }
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