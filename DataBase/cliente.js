// VER PERFIL CLIENTE - POST segun DNI ya obtenido traer el perfil de un cliente existente

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
const knex = require('./knexConfig.js');
const router = express.Router();

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

router.post('/getClientes', async (req, res) => {
    getClientes()
    .then ((resultadoGet) => {
        if (resultadoGet === undefined || resultadoGet === false) {
            res.status(401)
        } else {
            res.status(200).send(resultadoGet)
        }
    })
    .catch (() => {
        res.status(401)
    })
})

module.exports = router;