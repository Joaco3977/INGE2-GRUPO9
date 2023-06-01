<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"
    >
      <q-card-section class="column">
        <div class="column">
          <div class="textoPerfil q-py-sm">
            Fecha del turno: {{ formattedDate }}
          </div>
          <div v-if="rol === 2" class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Cliente:</div>
            <div>Nombre: {{ nombreCliente }} - DNI: {{ dniCliente }}</div>
          </div>
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
            <div>Nombre: {{ nombreVeterinario }}</div>
          </div>
        </div>
        <q-card-actions>
          <div class="row justify-end full-width q-pr-sm">
            <q-btn
              flat
              v-if="mostrarBoton()"
              class="q-ml-md"
              @click="cancelarTurno(id, state)"
            >
              <div>Cancelar Turno</div>
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
            label="Confirmar"
            @click="confirmarTurno(id)"
            color="primary"
            :disable="horaTurno.value == undefined"
            v-close-popup
          />
          <q-btn
            flat
            @click="reiniciarHora"
            label="Cancelar"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { useStore } from '../../pinia/store'

export default defineComponent({
  name: "TarjetaPaseador",
  components: {},
  props: {
    id: String,
    rol: String,
    state: String,
    dniCliente: String,
    nombreCliente: String,
    nombreVeterinario: String,
    nombrePerro: String,
    nombreVacuna: String,
    franjaHoraria: String,
    fecha: String,
    nombreServicio: String
  },
  setup() {
    const horaTurno = ref("");
    return {
      confirmar: ref(false),
      horaTurno,
      opcionHora: [
        { label: "Mañana", value: "Mañana" },
        { label: "Tarde", value: "Tarde" },
        { label: "Noche", value: "Noche" },
      ],
    };
  },
  methods: {
    cancelarTurno(id, state) {
      let data = {
        id: id,
        state: state
      }
      this.$emit("cancelarTurno", data);
    },
    confirmarTurno(id) {
      let data = {
        id: id,
        nombre: useStore().nombre,
        dni: useStore().dni,
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
      return this.state != 'Cancelado' && !this.esTurnoPasado();
    },
  },
  computed: {
    formattedDate() {
      const date = new Date(this.fecha);
      const options = { year: "numeric", month: "numeric", day: "numeric" };
      if (this.franjaHoraria !== null) {
        return (`${date.toLocaleDateString(undefined, options)} - Franja Horaria: ${this.franjaHoraria}`)
      } else return date.toLocaleDateString(undefined, options);
    },
    formattedService() {
      if (this.nombreServicio === 'Vacunación') {
        return (`Vacunación - Nombre Vacuna: ${this.nombreVacuna}`)
      } else return (this.nombreServicio)
    }
  },
});
</script>
