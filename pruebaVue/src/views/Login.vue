<script setup>
  import {ref, computed } from 'vue'
  import axios from 'axios'

  const loggedIn=ref(false)
  const mail =ref('');
  const password =ref('');

  axios.get('190.191.175.12:5137/usuarios')
  .then(response => {
    console.log(response.data)
  })

  function logout(){
    loggedIn.value=false
  }
  function login(){
    console.log(mail.value, "   ", password.value)
    const data = {
        mail: mail.value,
        password: password.value,
      } 
      axios.post('190.191.175.12:5137/intentoLogin', data)
      .then(response => {
         console.log(response);
      })
      .catch(error => {
        console.error(error);
      });
  }
</script>

<template>
    <div v-if="loggedIn">
      <p>Bienvenido, {{ username }}!</p>
      <button @click="logout">Cerrar sesión</button>
    </div>
    <div v-else>
      <h4>Iniciar Sesion</h4>
      <form @submit.prevent="login">
       <label for="mail">Mail:</label>
        <input type="text" id="mail" v-model="mail">
       <label for="password">Contraseña:</label>
       <input type="password" id="password" v-model="password">
       <button type="submit">Iniciar sesión</button>
     </form>
   </div>
</template>