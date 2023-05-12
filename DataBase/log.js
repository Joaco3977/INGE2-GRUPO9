const knex = require('./configs/knexConfig.js')

const agregarEntradaLog = async (rol, dni, queHizo) => {
    let quien = ''
    if (rol === 1) {
        quien = 'CLIENTE'
    } else {
        if (rol === 2) {
            quien = 'VETERINARIO'
        } else {
            quien = 'ADMIN'
        }
    }
    const descripcion = `[${quien} ${dni}] -- ${queHizo}`
    await knex('log').insert({
        FECHA: new Date(),
        DESCRIPCION: descripcion
    })
}

//ESTO ESTA FUNCIONAL Y YA EN MARCHA! VER LOG EN BD!

module.exports = { agregarEntradaLog }