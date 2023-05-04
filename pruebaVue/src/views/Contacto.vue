<script setup>
    import {ref, computed } from 'vue'
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
    <div v-if="rol === 3">
        <h4>ESTAS LOGUEADO COMO CLIENTE</h4>
    </div>
    <div v-if="rol === 2">
        <h4>ESTAS LOGUEADO COMO VETERINARIO</h4>
    </div>
    <div v-if="rol === 1">
        <h4>ESTAS LOGUEADO COMO ADMINISTRADOR</h4>
    </div>
    <div v-else>
        <h4>NO ESTAS LOGUEADO</h4>
    </div>
</template>