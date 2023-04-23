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
</template>