<script setup>
  var loggedIn = false;
</script>
<template>
    <div id="login">
      <div v-if="loggedIn">
      <p>Bienvenido, {{ username }}!</p>
      <button @click="logout">Cerrar sesión</button>
    </div>
    <div v-else>
      <form @submit.prevent="login">
        <h4>Iniciar Sesion</h4>
        <label for="username">Mail:</label>
        <input type="text" id="username" v-model="mail">
        <label for="password">Contraseña:</label>
        <input type="password" id="password" v-model="password">
        <button type="submit">Iniciar sesión</button>
      </form>
    </div>
  </div>
</template>
  
  <script>

  export default {
    data() {
      return {
        mail: '',
        password: '',
      };
    },
    methods: {
      login() {
        loggedIn = true;
      },
    },
  };

  </script>  