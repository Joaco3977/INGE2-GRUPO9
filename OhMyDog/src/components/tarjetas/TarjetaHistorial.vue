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
        <div v-if="historial.length > 0" class="full-width row wrap justify-center">
          <TarjetaEntradaHistorial
            class="q-px-sm col-stretch"
            v-for="entrada in historial"
            :key="entrada.FECHA"
            :rol="rol"
            :fecha="entrada.FECHA"
            :servicio="entrada.NOMBRESERVICIO"
            :comentario="entrada.COMENTARIO"
            :nombreVacuna="entrada.NOMBREVACUNA"
            :dniVet="entrada.DNIVET"
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
      <FormHistorial
        @registrarEntrada="registrarEntrada"
        :idPerro="idPerro"
      />
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
    idPerro: Number,
  },
  setup(props) {
    const mostrarPopup = ref("false");
    const rol = useStore().rol;
    const historial = ref([])

    const loadHistorial = async () => {
      await api.post('/historial/getHistorial', {
        id: props.idPerro,
      })
      .then((response) => {
        historial.value = response.data;
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const registrarEntrada = async (entrada) => {
      await api.post('/historial/agregarEntrada', {
        entrada: entrada,
      })
      .then(() => {
        loadHistorial();
      })
      .catch((error) => {
        console.log(error)
      })
    }

    return {
      rol,
      mostrarPopup,
      historial,
      loadHistorial,
      registrarEntrada,
    };
  },
  methods: {

  },
  mounted() {
    checkToken();
    this.loadHistorial();
  },
});
</script>
