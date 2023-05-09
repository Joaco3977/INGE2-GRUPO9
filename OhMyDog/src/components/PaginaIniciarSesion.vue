<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white column items-center" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-pt-md"> INICIAR SESIÓN </div>



      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <div class="q-pa-xl " style="width:50vw; height:80vh">
        <q-form class="q-pa-xl" @submit.prevent="login">
          <q-input class="q-px-xl" v-model="mail" label="Correo electrónico" type="email" />
          <q-input class="q-px-xl" v-model="password" label="Contraseña" type="password" />
          <q-btn push class="q-my-md q-mx-xl" color="accent" type="submit" label="Iniciar Sesión" />
        </q-form>
      </div>

      <!-- Hasta acá :)  -->

  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { useStore } from "../pinia/store.js";
import { api } from '../boot/axios.js';

export default defineComponent({
  name: "PaginaIniciarSesion",
  components: {},
  setup() {
    return {
      store : useStore(),
      mail: ref(""),
      password: ref(""),
    };
  },
  methods: {
    async login() {
      try {
        const response = await api.post("/login", {
          mail: this.mail,
          password: this.password,
        });
        localStorage.setItem("token", response.data.token);
        this.store.setRol(response.data.rol);
        this.store.setTab('Quienes Somos');
        if (this.store.rol == 1){
          response = await api.post("/cliente/getCliente", {
            mail: this.mail
          });
          this.store.setDni(response.data.dni)
        }else
        if (this.store.rol == 2){
          response = await api.post("/veterinario/getVeterinario", {
            mail: this.mail
          });
          this.store.setDni(response.data.dni)
        }
      } catch (error) {
        console.error(error);
      }
    },
  },
});
</script>
