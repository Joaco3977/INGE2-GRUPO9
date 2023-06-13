<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-primary full-height" style="width: 96%; height: 27vh">
    <q-card flat>
      <div class="bg-primary full-width flex justify-end">
        <q-btn @click="mostrarPopup = true" class="q-ma-sm" color="accent">
          <div>Agregar historial</div>
        </q-btn>
      </div>

      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 70vh; width: 100%"
        class="bg-primary full-width"
      >
        <div v-if="numeroMagico > 0" class="full-width row wrap justify-center">
          <TarjetaEntradaHistorial
            class="q-px-sm col-stretch"
            v-for="i in numeroMagico"
            :key="i"
            :rol="rol"
          />
        </div>

        <div v-else
          class="row textoNoItems text-white justify-center full-height content-center q-pa-xl"
        >
          ¡Todavía no hay historial!
        </div>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormHistorial @registrarPerro="registrarPerro" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import FormHistorial from "../formularios/formHistorial.vue";
import { useStore } from "../../pinia/store.js";
import { checkToken } from "../../functions/check.js";
import { api } from "../../boot/axios";
import TarjetaEntradaHistorial from "./TarjetaEntradaHistorial.vue";


export default defineComponent({
  name: "PaginaHistorial",
  components: {
    FormHistorial,
    TarjetaEntradaHistorial,
  },
  props: {
    nombrePerro: String,
  },
  setup() {
    const mostrarPopup = ref("false");
    const rol = useStore().rol;

    return {
      rol,
      mostrarPopup,
      numeroMagico: ref(5),
    };
  },
  methods: {
    async getPerroSeleccionado() {
      await api
        .post("/perro/getPerroPorNombre", {
          dni: useStore().dni,
          nombre: this.nombrePerro,
        })
        .then((response) => {
          console.log("esto recibí de get perro", response.data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  mounted() {
    checkToken();
  },
});
</script>
