<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white full-height" style="width: 96%; height: 27vh">
    <q-card flat>
      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 70vh; width: 100%"
        class="bg-white full-width"
      >
        <div v-if="numeroMagico > 0" class="full-width row wrap justify-center">
          <TarjetaEntradaHistorial
            class="q-px-sm col-stretch"
            v-for="i in numeroMagico"
            :key="i"
            :rol="rol"
          />
        </div>

        <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
        >
          ¡Todavía no tenemos ninguna donación en el sitio!
        </div>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormTurno @registrarPerro="registrarPerro" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import FormTurno from "../formularios/formTurno.vue";
import { useStore } from "../../pinia/store.js";
import { checkToken } from "../../functions/check.js";
import { api } from "../../boot/axios";
import TarjetaEntradaHistorial from "./TarjetaEntradaHistorial.vue";

const numeroMagico = 5;

export default defineComponent({
  name: "PaginaTurnos",
  components: {
    FormTurno,
    TarjetaEntradaHistorial,
  },
  props: {
    nombrePerro: String,
  },
  setup() {
    const mostrarPopup = ref("false");
    const tab = ref("turnosConfirmados");
    const listaTurnos = ref([]);
    const rol = useStore().rol;

    const mostrarPopupM = () => {
      mostrarPopup.value = !mostrarPopup.value;
    };

    return {
      tab,
      rol,
      listaTurnos,
      mostrarPopup,
    };
  },
  methods: {
    async loadTurnosPropios(estado) {
      await api
        .post("/turno/getTurnosDni", {
          dni: useStore().dni,
          estado: estado,
        })
        .then((response) => {
          console.log(response.data);
          this.listaTurnos = response.data;
          //.filter((turno) => turno.IDPERRO == this.idPerro);
          //this.getPerroSeleccionado();
        })
        .catch((error) => {
          console.log(error);
        });
    },

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
    this.loadTurnosPropios("Confirmado");
  },
});
</script>
