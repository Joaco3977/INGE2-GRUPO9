<template>
  <div class="bg-white" style="width: full; max-height: 90vh">

      <div class="text-center text-h4 text-primary "> CERRAR SESION </div>
      <div class="text-center text-h6 text-primary "> Hola! Soy el componente "Página cerrar sesion" EDITAME </div>

      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 80vh;"
        class="bg-white"
      >

      <q-btn @click="cerrarSesion()"> Cerrar Sesion </q-btn>

      </q-scroll-area>
  </div>

  </template>

  <script>
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import { api } from '../boot/axios.js'
  import { LocalStorage } from 'quasar';
  import { useStore } from "../pinia/store.js";

  export default defineComponent({
  name: "PaginaCerrarSesion",
  components: {},
  setup() {
    return {
      store : useStore(),
    };
  },
  methods: {
    async cerrarSesion() {
      try {
        const response = await api.post("/logout", {
          token: LocalStorage.getItem('token')
        });
        if (response) {
          this.store.setRol(0);
          this.store.setTab('Iniciar Sesion');
          LocalStorage.clear()
        }
      } catch (error) {
        console.error(error);
      }
    },
  },
});
  </script>
