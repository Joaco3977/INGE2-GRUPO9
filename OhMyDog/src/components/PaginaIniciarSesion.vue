<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div
    class="bg-white column items-center"
    style="width: full; max-height: 90vh"
  >
    <div class="text-center text-h4 text-primary q-pt-md">INICIAR SESIÓN</div>

    <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

    <div class="q-pa-xl" style="width: 50vw; height: 80vh">
      <q-form @click="mensajeError = ''" Fclass="q-pa-xl" @submit.prevent="login">
        <q-input
          class="q-px-xl"
          v-model="mail"
          label="Correo electrónico"
          type="email"

        />
        <q-input
          class="q-px-xl"
          v-model="password"
          label="Contraseña"
          type="password"
        />
        <q-btn
          push
          class="q-my-md q-mx-xl"
          color="accent"
          type="submit"
          label="Iniciar Sesión"
        />
      </q-form>
      <div class="bg-white text-accent text-bold text-center">
        {{ mensajeError }}
      </div>
    </div>

    <!-- Hasta acá :)  -->
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";

export default defineComponent({
  name: "PaginaIniciarSesion",
  components: {},
  setup() {
    return {
      mensajeError: ref(""),
      store: useStore(),
      mail: ref(""),
      password: ref(""),
    };
  },
  methods: {
    async login() {
      try {
        var response = await api.post("/login", {
          mail: this.mail,
          password: this.password,
        });
        localStorage.setItem("token", response.data.token);
        this.store.setRol(response.data.rol);
        if (response.data.rol > 0) {
          this.store.setDni(response.data.dni);
          this.store.setTab("Mi Perfil");
          this.store.setNombre(response.data.nombre)
          this.store.setMail(this.mail);
        } else if(response.data.rol === -1) {
          this.store.setTab("Veterinarios");
        }
      } catch (error) {
        console.error(error.response);
        this.mensajeError = "Los datos ingresados son incorrectos";
      }
    },
  },
});
</script>
