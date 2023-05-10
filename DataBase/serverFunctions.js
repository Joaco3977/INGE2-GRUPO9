const mensaje = (color, mensaje) => {
    const date = new Date()
    const hora = date.getHours()
    const minuto = date.getMinutes()
    const segundo = date.getSeconds()
    console.log(color,`[${hora}:${minuto}:${segundo}] - ${mensaje}`)
}

module.exports = { mensaje }