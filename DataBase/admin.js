 // VER LOG - GET traer todos las entradas

 // FILTRAR LOG - seria interno en JS, con el GET ya dado de arriba, puesto q no podemos filtrar por string en BD  Ó  con filtro Like en BD.

/*
si (es admin) {
    rol -1
    corto
} sino {
    si (es veterinario) {
        rol 2
        corto
    } sino {
        si (es cliente) {
            rol 1
            corto
        } sino {
            notificar las credenciales no son validas
        }
    }
}
*/

const express = require('express');
const knex = require ('./configs/knexConfig')

const router = express.Router();
const Sesion = require ('./sesion.js')

const sacarTiempo = () => {
    const fecha = new Date();
    const dia = fecha.getDate();
    const mes = fecha.getMonth() + 1; // El mes se devuelve en base 0, por lo que se le suma 1
    const anio = fecha.getFullYear();
    const hora = fecha.getHours();
    const minutos = fecha.getMinutes();

    const timestamp = `${dia}/${mes}/${anio} ${hora}:${minutos}`;

    return timestamp
}

/*
const agregarEntradaLog = async (tokenQuien, queHizo) => {
    Sesion.getInfoQuien(tokenQuien)
    .then ((resultado) => {
        if (resultado !== false) {
            const msg = ''
            if (resultado.rol === 1) {
                msg = `[${sacarTiempo}] CLIENTE ${resultado.nombre}, con DNI: ${resultado.dni} ${queHizo}`
            } else {
                msg = `[${sacarTiempo}] VETERINARIO ${resultado.nombre}, con DNI: ${resultado.dni} ${queHizo}`
            }
            knex('log').insert({
                FECHA: new Date(),
                DESCRIPCION: msg,
            }).then(() => {
                return true
            }).catch((error) => {
                console.error('Error al insertar log:', error);
            })
        }
    })
}
*/

router.get('/getLog', async (req, res) => {
    knex('log').select('*')
    .then((resultado) => {
        res.status(200).send(resultado)
    })
    .catch((error) => {
        res.status(401)
        console.error(error)
    })
})

module.exports = router ; //agregarEntradaLog