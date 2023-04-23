<script setup>
  import {ref, computed } from 'vue'
  import axios from 'axios'
  
  var dirBD = 'http://190.191.175.12:5137'

  const loggedIn=ref(false)
  const mail =ref('')
  const password =ref('')

  const username = ref('')

  axios.get(`${dirBD}/usuarios`)
  .then(response => {
    console.log(response.data)
  })

  function logout(){
    const data = {
      token: localStorage.getItem('token')
    }
    axios.post(`${dirBD}/logout`, data)
    .then(res => {
      loggedIn.value = false
      localStorage.removeItem('token')
      localStorage.removeItem('username')
    })
  }

  function login(){
    console.log(mail.value, "   ", password.value)
    const data = {
        mail: mail.value,
        password: password.value,
      } 
      axios.post(`${dirBD}/intentoLogin`, data)
      .then(response => {
        if (response.status==200) {
          console.log(response.data)
          localStorage.setItem('token',response.data.token);
          username.value = response.data.username;
          loggedIn.value = true;
        } else {
          console.log(response.data)
        }
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