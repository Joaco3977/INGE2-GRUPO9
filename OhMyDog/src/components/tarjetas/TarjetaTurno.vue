<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"
    >
    <div class="bg-primary full-width flex justify-end">
        <q-btn v-if="rol == 2 && (state === 'Confirmado')" @click="mostrarPopup = true" class="q-ma-sm" color="accent">
          <div>Agregar historial</div>
        </q-btn>
    </div>
      <q-card-section class="column">
        <div class="column">
          <div class="textoPerfil q-py-sm">
            Fecha del turno: {{ formattedDate }}
          </div>
          <div v-if="rol === 2" class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Cliente:</div>
            <div>{{ nombreCliente }} - DNI: {{ dniCliente }}</div>
          </div>
          <div  v-if="rol === 2 && (state === 'Confirmado' || state === 'Pendiente')" class="textoTituloPosteo q-pr-sm q-pb-xs">Monto Beneficio: {{ beneficio }}</div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Perro:</div>
            <div>{{ nombrePerro }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Servicio:</div>
            <div>{{ formattedService }}</div>
          </div>
          <div v-if="state === 'Confirmado'" class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Veterinario:</div>
            <div>{{ nombreVeterinario }}</div>
          </div>
        </div>
        <q-card-actions>
          <div class="row justify-end full-width q-pr-sm">
            <q-btn
              flat
              v-if="mostrarBoton()"
              class="q-ml-md"
              @click="confirmarCancelar = true"
            >
              <div v-if="state == 'Pendiente' && rol == 2">Rechazar</div>
              <div v-else>Cancelar turno</div>
            </q-btn>
            <!--<q-btn flat v-if="rol == 2 && state == 'Pendiente'" class="q-ml-md">
              <div>Rechazar</div>
            </q-btn> -->
            <q-btn
              v-if="rol == 2 && state == 'Pendiente'"
              class="q-ml-md"
              color="accent"
              @click="confirmar = true"
            >
              <div>Confirmar</div>
            </q-btn>
          </div>
        </q-card-actions>
      </q-card-section>
    </q-card>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Confirmar horario</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-select
            v-model="horaTurno"
            :options="opcionHora"
            class="q-px-none"
            label="Bloque horario"
          />
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            @click="reiniciarHora"
            label="Cancelar"
            color="primary"
            v-close-popup
          />
          <q-btn
            flat
            label="Confirmar"
            @click="confirmarTurno(id)"
            color="primary"
            :disable="horaTurno.value == undefined"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="confirmarCancelar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Cancelar turno</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-input
          v-if="rol === 2"
          class="q-px-lg"
          filled
          v-model="motivo"
          label="Motivo"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            @click="cancelarTurno(id, state, motivo)"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Volver" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>

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
import { useStore } from "../../pinia/store";
import { api } from "src/boot/axios";
import FormHistorial from "../formularios/formHistorial.vue";

export default defineComponent({
  name: "TarjetaTurno",
  components: {
    FormHistorial,
  },
  props: {
    id: String,
    rol: String,
    state: String,
    dniCliente: String,
    nombreCliente: String,
    idPerro:String,
    nombreVeterinario: String,
    nombrePerro: String,
    nombreVacuna: String,
    franjaHoraria: String,
    fecha: String,
    nombreServicio: String,
  },
  setup(props, { emit }) {
    const horaTurno = ref("");
    const motivo = ref("")
    const beneficio = ref("")
    const mostrarPopup = ref("false");
    const registrarEntrada = async (entrada) => {
      await api.post('/historial/agregarEntrada', {
        entrada: entrada,
      })
      .then(() => {
      })
      .catch((error) => {
        console.log(error)
      })
    }
    return {
      confirmar: ref(false),
      confirmarCancelar: ref(false),
      horaTurno,
      beneficio,
      mostrarPopup,
      registrarEntrada,
      opcionHora: [
        { label: "Mañana", value: "Mañana" },
        { label: "Tarde", value: "Tarde" },
        { label: "Noche", value: "Noche" },
      ],
      motivo,
    };
  },
  methods: {
    cancelarTurno(id, state, motivo) {
      let data = {
        id: id,
        state: state,
        motivo: motivo,
      };
      this.$emit("cancelarTurno", data);
    },
    confirmarTurno(id) {
      let data = {
        id: id,
        nombre: useStore().nombre,
        dni: useStore().dni,
        dniCliente: this.dniCliente,
        franjaHoraria: this.horaTurno.value,
      };
      this.$emit("confirmarTurno", data);
    },
    esTurnoPasado() {
      const hoy = new Date().toISOString();
      //console.log("la fecha: ", this.fecha, hoy, this.fecha < hoy)
      return this.fecha < hoy;
    },
    mostrarBoton() {
      return this.state != "Cancelado" && !this.esTurnoPasado();
    },
    async obtenerBeneficio() {
      try {
        const response = await api.post("/cliente/getBeneficio", { dni: this.dniCliente });
        this.beneficio = response.data.beneficio;
      } catch (error) {
        console.log(error);
      }
    },
  },
  computed: {
    formattedDate() {
      const date = new Date(this.fecha);
      const options = { year: "numeric", month: "numeric", day: "numeric" };
      if (this.franjaHoraria !== null) {
        return `${date.toLocaleDateString(
          undefined,
          options
        )} - Franja Horaria: ${this.franjaHoraria}`;
      } else return date.toLocaleDateString(undefined, options);
    },
    formattedService() {
      if (this.nombreServicio === "Vacunación") {
        return `Vacunación - Nombre Vacuna: ${this.nombreVacuna}`;
      } else return this.nombreServicio;
    },
  },
  created() {
    this.obtenerBeneficio();
  }
});
</script>
