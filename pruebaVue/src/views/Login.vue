<script setup>
  import {ref, computed } from 'vue'
  import axios from 'axios'

  const loggedIn=ref(false)
  const username =ref('');
  const password =ref('');

  function logout(){
    loggedIn.value=false
  }
  function login(){
    console.log(username.value)
    console.log(password.value)
    if (username.value == "renzo") {
      console.log("entre")
      loggedIn.value=true
    }
  }
</script>

<template>
    <div v-if="loggedIn">
      <p>Bienvenido, {{ username }}!</p>
      <button @click="logout">Cerrar sesión</button>
    </div>
    <div v-else>
      <form @submit.prevent="login">
       <label for="username">Nombre de usuario:</label>
        <input type="text" id="username" v-model="username">
       <label for="password">Contraseña:</label>
       <input type="password" id="password" v-model="password">
       <button type="submit">Iniciar sesión</button>
     </form>
   </div>
</template>