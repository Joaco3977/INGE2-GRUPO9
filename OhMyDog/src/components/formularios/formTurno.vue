<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Pedir turno
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" reset>
          <!-- las opciones deberian ser los perros de cliente -->
          <q-select
            v-model="nombrePerro"
            :options="opcionPerros"
            class="q-px-xl"
            label="Perro"
          />
          <q-select
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
          <div class="column items-center bg-white q-pa-sm">
            <div class="q-px-xl q-py-sm text-start self-start color-grey">
              Fecha y hora del turno:
            </div>
            <q-date
              class="q-mb-lg"
              v-model="fechaTurno"
              minimal
              :options="opcionesFecha"
            />

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
            <q-btn @click="pedirTurno(pestania)" label="Pedir turno" color="accent" v-close-popup />
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
    misPerros: {
      type: Array,
      default: () => [], // Set the default value as an empty array
    },
    pestania: String,
  },
  setup(props) {
    const $q = useQuasar();

    const nombrePerro = ref("");
    const nombreServicio = ref("");
    const nombreVacuna = ref("");
    const clienteDNI = useStore().dni;
    const fechaTurno = ref("")

    const getDatosTurno = () => {
      let turno = null
      const perroEncontrado = props.misPerros.find(perro => perro.NOMBRE === nombrePerro.value.value);
      if (nombreVacuna.value.value !== undefined) {
        turno = {
          IDPERRO: perroEncontrado.ID,
          DNICLIENTE: useStore().dni,
          FECHA: formatearFecha(new Date(fechaTurno.value)),
          ESTADO: 'Pendiente',
          NOMBREVACUNA: nombreVacuna.value.value,
          NOMBREPERRO: nombrePerro.value.value,
          NOMBRESERVICIO: nombreServicio.value.value,
          NOMBRECLIENTE: useStore().nombre,
        }
      } else {
        turno = {
          IDPERRO: perroEncontrado.ID,
          DNICLIENTE: useStore().dni,
          FECHA: formatearFecha(new Date(fechaTurno.value)),
          ESTADO: 'Pendiente',
          NOMBREPERRO: nombrePerro.value.value,
          NOMBRESERVICIO: nombreServicio.value.value,
          NOMBRECLIENTE: useStore().nombre,
      };
      }
      return turno;
    };

    const onReset = () => {
      console.log("Los datos están mal!");
      nombrePerro.value = "";
      nombreServicio.value = "";
      nombreVacuna.value = "";
      return false;
    };

    const opcionesFecha = (date) => {
      const hoy = new Date().toLocaleDateString("zh-Hans-CN", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      return date >= hoy;
    };

    watch(nombreServicio, (newNombreServicio) => {
      // Update nombreVacuna based on the value of nombreServicio
      if (newNombreServicio != "Vacunación") {
        nombreVacuna.value = ""; // Update nombreVacuna to an empty string
      }
      // Add other conditions or update logic as needed
    });

    const formatearFecha = (fechaString) => {
      const fecha = new Date(fechaString);

      const year = fecha.getFullYear();
      const month = (fecha.getMonth() + 1).toString().padStart(2, '0');
      const day = fecha.getDate().toString().padStart(2, '0');
      const hours = fecha.getHours().toString().padStart(2, '0');
      const minutes = fecha.getMinutes().toString().padStart(2, '0');
      const seconds = fecha.getSeconds().toString().padStart(2, '0');

      const fechaFormateada = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

      return fechaFormateada
    }

    return {
      nombrePerro,
      nombreServicio,
      nombreVacuna,
      opcionesFecha,
      fechaTurno,
      clienteDNI,
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

      opcionPerros: props.misPerros.map((perro) => {
        return { label: perro.NOMBRE, value: perro.NOMBRE };
      }),
    };
  },
  methods: {
    pedirTurno(pestania) {
      const turno = this.getDatosTurno();
      let data = {
        turno: turno,
        pestania: pestania
      }
      this.$emit("registrarTurno", data);
    },
  },
  computed: {
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
      if (!this.fechaValida){
        sError.push("Elija una fecha");
      }
      return sError;
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
    fechaValida(){
      return this.fechaTurno != undefined;
    },
    camposValidos() {
      return this.perroValido && this.servicioValido && this.vacunaValida && this.fechaValida;
    },
  },
});
</script>
