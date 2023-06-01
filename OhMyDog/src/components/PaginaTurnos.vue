<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        TURNOS
      </div>
      <q-btn
        v-if="rol > 0"
        @click="mostrarPopup = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Pedir turno</div>
      </q-btn>
    </div>

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
          @click="loadTurnosPropiosFecha('Pasado')"
          name="turnosPasados"
          label="Pasados"
        />
        <q-tab
          @click="loadTurnosPropios('Pendiente')"
          name="turnosSolicitados"
          label="Pendientes"
        />
        <q-tab
          @click="loadTurnosPropiosFecha('Confirmado')"
          name="turnosConfirmados"
          label="Confirmados"
        />
      </q-tabs>

      <q-separator></q-separator>

      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 75vh; width: 100%"
        class="bg-white full-width"
      >
        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="turnosCancelados">
            <div></div>
            <TarjetaTurno
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :id="turno.ID"
              :rol="rol"
              :state="'Cancelado'"
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
              :id="turno.ID"
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
              @confirmarTurno="confirmarTurno"
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :id="turno.ID"
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
              @cancelarTurno="cancelarTurno"
              v-for="turno in listaTurnos"
              :key="turno.ID"
              :id="turno.ID"
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
      <FormTurno @registrarTurno="registrarTurno" :misPerros="misPerros" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaTurno from "./tarjetas/TarjetaTurno.vue";
import TarjetaTurnoCancelado from "./tarjetas/TarjetaTurnoCancelado.vue";
import FormTurno from "./formularios/formTurno.vue";
import { useStore } from "../pinia/store.js";
import { checkToken } from "src/functions/check.js";
import { api } from "src/boot/axios";

export default defineComponent({
  name: "PaginaTurnos",
  components: {
    TarjetaTurno,
    FormTurno,
  },
  setup() {
    const misPerros = ref([]);

    const mostrarPopup = ref("false");
    const tab = ref("turnosConfirmados");
    const listaTurnos = ref([]);
    const rol = useStore().rol;

    const mostrarPopupM = () => {
      mostrarPopup.value = !mostrarPopup.value;
    };

    const confirmarTurno = async(id) => {
      await api
      .post("/turno/confirmarTurno", id)
      .then(()=>{
        loadTurnosPropio('Pendiente')
      })
      .catch((error) => {
          console.log(error);
      })
    }

    const cancelarTurno = async(id) => {
      await api
      .post("/turno/cancelarTurno", id)
      .then(()=>{
        loadTurnosPropios('Cancelado')
      })
      .catch((error) => {
          console.log(error);
      })
    }

    const loadTurnosPropiosFecha = async(estado) => {
      await api
      .post("/turno/getTurnosDni", {
          dni: useStore().dni,
          estado: 'Confirmado',
        })
        .then((response) => {
          if (estado === 'Confirmado') {
            listaTurnos.value = response.data.filter((turno) =>
              (new Date()) <= new Date(turno.FECHA)
            );
          } else {
            listaTurnos.value = response.data.filter((turno) =>
              (new Date()) >= new Date(turno.FECHA)
            );
          }
        })
        .catch((error) => {
          console.log(error);
        });
    }

    const loadTurnosPropios = async(estado) => {
      await api
        .post("/turno/getTurnosDni", {
          dni: useStore().dni,
          estado: estado,
        })
        .then((response) => {
          listaTurnos.value = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    }

    const registrarTurno = async (turno) => {
      await api
        .post("/turno/pedirTurno", {
          turno: turno
        })
        .then(() => {
          console.log('salio todo un lujo')
        })
        .catch((error) => {
          console.log(error);
        });
    }

    return {
      tab,
      rol,
      listaTurnos,
      mostrarPopup,
      misPerros,
      cancelarTurno,
      confirmarTurno,
      loadTurnosPropios,
      loadTurnosPropiosFecha,
      registrarTurno
    };
  },
  methods: {
    async loadPerrosPropios() {
      try {
        const response = await api.post("/perro/getPerrosPropios",{ dni : useStore().dni })
        this.misPerros = response.data
      }
      catch (error) {
        console.error(error);
      }
    },
  },
  mounted() {
    checkToken();
    this.loadTurnosPropiosFecha("Confirmado");
    this.loadPerrosPropios();
  },
});
</script>
