<script setup>
  import {ref} from 'vue'
  import axios from 'axios'
  
  var dirBD = 'http://190.191.175.12:5137'

  const nombreRol=ref('')

  const cheqRol = () => {
    axios.post(`${dirBD}/pedirRol`, { token : localStorage.getItem('token') })
      .then(res => {
        if (res.status = 200) {
          if (res.data.rol === 3) {
            nombreRol.value = 'Cliente'
          } else {
            if (res.data.rol === 2) {
              nombreRol.value = 'Veterinario'
            } else {
              nombreRol.value = 'Administrador'
            }
          }
        } else {
          
        }
    })
  } 

  cheqRol()

  console.log(nombreRol.value)

</script>
<template>
  <h1>OhMyDog</h1>
  <router-link to="/sobrenosotros"> Sobre nosotros </router-link><br>
  <div v-if="nombreRol === ''">
    <router-link to="/login"> Iniciar Sesion </router-link><br>
  </div>
  <div v-else>
    <router-link to="/login"> Menu para {{ nombreRol }} </router-link><br>
  </div>
  <router-link to="/servicios"> Servicios </router-link><br>
  <router-link to="/donar"> Donaciones </router-link><br>
  <router-link to="/contacto"> Contacto </router-link>
  <router-view></router-view>
</template>