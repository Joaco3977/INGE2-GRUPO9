<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary">MI PERFIL</div>
    <div class="text-center text-h6 text-primary">
      Hola! Soy el componente "Página Perfil" EDITAME
    </div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh"
      class="bg-white"
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <div>
        <h6> Nombre y Apellido: {{ misDatos.NOMBREAPELLIDO }} </h6>
        <p> DNI: {{ misDatos.DNI }} </p>
        <p> Mail: {{ misDatos.MAIL }} </p>
        <p> Telefono: {{ misDatos.TELEFONO }} </p>
        <p v-if="rol ===  1"> Direccion: {{ misDatos.DIRECCION }} </p>
        <p> Fecha de registro: {{ misDatos.FECHAREGISTRO }} </p>
      </div>

      <q-btn @click="cerrarSesion()"> Cerrar Sesion </q-btn>

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { checkToken } from "../functions/check.js";
import { useStore } from '../pinia/store.js'
import { api } from '../boot/axios.js'
import { LocalStorage } from 'quasar';


export default defineComponent({
  name: "PaginaPerfil",
  components: {},
  setup() {
    const rol = useStore().rol
    const misDatos = ref ({})

    const traerDatos = async () => {
      let url = ''
      if (rol === 1) {
        url = "/cliente/getCliente"
      } else url = "/veterinario/getVeterinario"
      try {
        const response = await api.post(`${url}`, {
          dni: useStore().dni,
        });
        misDatos.value = response.data;
        console.log(misDatos.value)
      } catch {
        console.log('No se pudo solicitar la operacion correspondiente')
      }
    }

    return {
      rol,
      misDatos,
      traerDatos: ref(traerDatos),
      store : useStore(),
    }
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
  mounted() {
    checkToken()
    this.traerDatos()
  }
});
</script>
