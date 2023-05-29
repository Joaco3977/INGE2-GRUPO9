<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white full-height" style="width:96%; height: 27vh">

    <q-card flat>
      <q-tabs
        v-model="tab"
        dense
        flat
        class="text-grey q-pt-md"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <q-tab
          @click="loadTurnosPropios('Cancelado')"
          name="turnosCancelados"
          label="Cancelados"
        />
        <q-tab
          @click="loadTurnosPropios('Pasado')"
          name="turnosPasados"
          label="Pasados"
        />
        <q-tab
          @click="loadTurnosPropios('Pendiente')"
          name="turnosSolicitados"
          label="Pendientes"
        />
        <q-tab
          @click="loadTurnosPropios('Confirmado')"
          name="turnosConfirmados"
          label="Confirmados"
        />
      </q-tabs>

      <q-separator></q-separator>

      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 50vh; width: 100%"
        class="bg-white full-width"
      >
        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="turnosCancelados">
            <div></div>
            <TarjetaTurno
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :rol="rol"
              :state="turno.ESTADO"
              :cliente="turno.DNICLIENTE"
              :nombrePerro="turno.IDPERRO"
              :fecha="turno.FECHA"
              :nombreServicio="turno.IDSERVICIO"
            />
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="listaTurnos.length == 0"
            >
              ¡No tenés ningún turno cancelado!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosPasados">
            <TarjetaTurno
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :rol="rol"
              :state="turno.ESTADO"
              :cliente="turno.DNICLIENTE"
              :nombrePerro="turno.IDPERRO"
              :fecha="turno.FECHA"
              :nombreServicio="turno.IDSERVICIO"
            />
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="listaTurnos.length == 0"
            >
              ¡No tenés ningún turno pasado!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosSolicitados">
            <TarjetaTurno
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :rol="rol"
              :state="turno.ESTADO"
              :cliente="turno.DNICLIENTE"
              :nombrePerro="turno.IDPERRO"
              :fecha="turno.FECHA"
              :nombreServicio="turno.IDSERVICIO"
            />
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="listaTurnos.length == 0"
            >
              ¡No tenés ningún turno pendiente!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosConfirmados">
            <TarjetaTurno
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :rol="rol"
              :state="turno.ESTADO"
              :cliente="turno.DNICLIENTE"
              :nombrePerro="turno.IDPERRO"
              :fecha="turno.FECHA"
              :nombreServicio="turno.IDSERVICIO"
            />
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="listaTurnos.length == 0"
            >
              ¡No tenés ningún turno Confirmado!
            </div>
          </q-tab-panel>
        </q-tab-panels>
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
import TarjetaTurno from "../tarjetas/TarjetaTurno.vue";
import FormTurno from "../formularios/formTurno.vue";
import { useStore } from  "../../pinia/store.js"
import { checkToken } from "../../functions/check.js"
import { api } from "../../boot/axios"

export default defineComponent({
  name: "PaginaTurnos",
  components: {
    TarjetaTurno,
    FormTurno,
  },
  props:{
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
          this.listaTurnos = response.data
          //.filter((turno) => turno.IDPERRO == this.idPerro);
          //this.getPerroSeleccionado();
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async getPerroSeleccionado(){
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
    }
  },
  mounted() {
    checkToken();
    this.loadTurnosPropios("Confirmado");
  },
});
</script>
