const menor10 = (num) => {
    if (num < 10) {
        return `0${num}`
    } else return num
}

const mensaje = (color, mensaje) => {
    const date = new Date()
    const hora = date.getHours()
    const minuto = date.getMinutes()
    const segundo = date.getSeconds()
    console.log(color,`[${menor10(hora)}:${menor10(minuto)}:${menor10(segundo)}] - ${mensaje}`)
}

module.exports = { mensaje }