<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary">Iniciar Sesion</div>
    <div class="text-center text-h6 text-primary">
      Hola! Soy el componente "Iniciar sesion" EDITAME
    </div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh"
      class="bg-white"
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <div>Iniciar sesion</div>

      <div class="q-pa-md">
        <q-form @submit.prevent="login">
          <q-input v-model="email" label="Email" type="email" />
          <q-input v-model="password" label="Password" type="password" />
          <q-btn type="submit" label="Login" />
        </q-form>
      </div>

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
//import { data } from "../pages/IndexPage.vue";

export default defineComponent({
  name: "PaginaIniciarSesion",
  components: {},
  setup() {
    return {
      email: ref(""),
      password: ref(""),
    };
  },
  methods: {
    /*
    async login() {
      try {
        const response = await axios.post("  ", {
          email: this.email,
          password: this.password,
        });
        localStorage.setItem("token", response.data.token);
        rol.value = response.data.rol;

      } catch (error) {
        console.error(error);
      }
    },*/
    login() {
      rol.value = 1;
    },
  },
});
</script>
