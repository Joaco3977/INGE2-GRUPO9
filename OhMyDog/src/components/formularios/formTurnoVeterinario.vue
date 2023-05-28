<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Pedir turno
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <!-- las opciones deberian ser los perros de cliente -->
          <q-select
            v-model="clienteDNI"
            :options="opcionClientes"
            class="q-px-xl"
            label="Cliente"
          />
          <q-select v-if="hayCliente"
            v-model="nombrePerro"
            :options="opcionPerros"
            class="q-px-xl"
            label="Perro"
          />
          <q-select v-if="hayCliente"
            v-model="nombreServicio"
            :options="opcionServicio"
            class="q-px-xl"
            label="Servicio"
          />
          <q-select
            v-if="esVacuna"
            v-model="nombreVacuna"
            :options="opcionVacuna"
            class="q-px-xl"
            label="Vacuna"
          />
          <div v-if="hayCliente" class="column items-center bg-white q-pa-sm">
            <div class="q-px-xl q-py-sm text-start self-start color-grey">
              Fecha y hora del turno:
            </div>
            <q-date class="q-mb-lg"
              
              v-model="fechaTurno"
              minimal
              :options="opcionesFecha"
            />
            <q-time minimal v-model="horaTurno" />
          </div>
          <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>
          <div class="row justify-end q-pt-xl">
            
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn label="Pedir turno" color="accent" v-close-popup />
          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref, watch } from "vue";
import { useStore } from "src/pinia/store";
import { useQuasar } from "quasar";

export default defineComponent({
  name: "formTurno",
  props: {
    misClientes: {
      type: Array,
      default: () => [], // Set the default value as an empty array
    },
  },
  setup(props) {
    const $q = useQuasar();

    const nombrePerro = ref("");
    const nombreServicio = ref("");
    const nombreVacuna = ref("");
    const clienteDNI = ref("");
    const fechaTurno = ref("");
    const horaTurno = ref("");

    const getDatosTurno = () => {
      const perro = {
        nombre: nombrePerro.value.value,
        servicio: nombreServicio.value.value,
        vacuna: nombreVacuna.value,
        dnicliente: clienteDNI,
      };
      return perro;
    };

    const onReset = () => {
      console.log("Los datos están mal!");
      nombreCliente.value ="";
      nombrePerro.value = "";
      nombreServicio.value = "";
      nombreVacuna.value = "";
      return false;
    };

    const opcionesFecha = (date) => {
      const hoy = new Date().toLocaleDateString('zh-Hans-CN', {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      return date >= hoy
    };

    watch(nombreServicio, (newNombreServicio) => {
      // Update nombreVacuna based on the value of nombreServicio
      if (newNombreServicio != "Vacunación") {
        nombreVacuna.value = ""; // Update nombreVacuna to an empty string
      }
      // Add other conditions or update logic as needed
    });

    return {
      nombrePerro,
      nombreServicio,
      nombreVacuna,
      clienteDNI,
      fechaTurno,
      horaTurno, 

      opcionServicio: [
        { label: "Consulta", value: "Consulta" },
        { label: "Vacunación", value: "Vacunación" },
        { label: "Desparacitación", value: "Desparacitación" },
        { label: "Castración", value: "Castración" },
      ],
      opcionVacuna: [
        { label: "Rabia", value: "Rabiea" },
        { label: "Parvovirus canino", value: "Parvovirus canino" },
        { label: "Moquillo", value: "Moquillo" },
        { label: "Hepatitis canina", value: "Hepatitis canina" },
      ],
      getDatosTurno,
      onReset,
      opcionesFecha,

      opcionClientes: [
        { label: "cliente", value: "cliente" },
      ],

      opcionPerros: [
        { label: "perro1", value: "perro1" },
      ],
    };
  },
  methods: {
    ejecutarFuncionPadre() {
      const turno = this.getDatosTurno();
      this.$emit("registrarTurno", turno);
    },
  },
  computed: {
    hayCliente(){
      return this.clienteDNI.value != undefined
    },
    esVacuna() {
      return this.nombreServicio.value === "Vacunación";
    },
    mensajeError() {
      let sError = [];
      if (!this.perroValido) {
        sError.push("Elija un perro");
      }
      if (!this.servicioValido) {
        sError.push("Elija un sevicio");
      }
      if (!this.vacunaValida) {
        sError.push("Elija una vacuna");
      }
      return sError;
    },
    clienteValido(){
      return this.nombreCliente != undefined;
    },
    perroValido() {
      return this.nombrePerro.value != undefined;
    },
    servicioValido() {
      return this.nombreServicio.value != undefined;
    },
    vacunaValida() {
      return (
        this.nombreServicio.value != "Vacunación" ||
        this.nombreVacuna.value != undefined
      );
    },
    camposValidos() {
      return this.clienteValido && this.perroValido && this.servicioValido && this.vacunaValida;
    },
  },
});
</script>
