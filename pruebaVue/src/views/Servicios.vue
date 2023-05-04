<script setup>
    import {ref } from 'vue'
    import axios from 'axios'
    var dirBD = 'http://190.191.175.12:5137'

    const rol = ref(0)
    const vef = () => {
        axios.post(`${dirBD}/pedirRol`, { token : localStorage.getItem('token') })
            .then(res => {
                rol.value = res.data.rol
            })
    }
    vef()
</script>
<template>
    <h4> Nuestros servicios </h4>
    <div>
        <h4>ADOPCION</h4>
    </div>
    <div>
        <h4>VETERINARIAS DE TURNO</h4>
    </div>
    <div>
        <h4>PASEADORES</h4>
    </div>
    <div>
        <h4>PERROS PERDIDOS</h4>
    </div>
    <div>
        <h4>CONSULTAS</h4>
    </div>
    <div v-if="rol > 0">
        <h4>CRUZA DE PERROS</h4>
    </div>
</template>