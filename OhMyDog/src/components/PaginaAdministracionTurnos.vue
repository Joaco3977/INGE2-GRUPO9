<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        ADMINISTRACIÓN TURNOS
      </div>
      <q-btn
        v-if="rol > 0"
        @click="mostrarPopup = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Crear turno</div>
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
          @click="loadTurnos('Cancelado')"
          name="turnosCancelados"
          label="Cancelados"
        />
        <q-tab
          @click="loadTurnosFecha('Pasado')"
          name="turnosPasados"
          label="Pasados"
        />
        <q-tab
          @click="loadTurnos('Pendiente')"
          name="turnosSolicitados"
          label="Pendientes"
        />
        <q-tab
          @click="loadTurnosFecha('Confirmado')"
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
            <TarjetaTurno
              @ejecutarFuncion="setEstado"
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
              ¡No hay ningún turno cancelado!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosPasados">
            <TarjetaTurno
              @ejecutarFuncion="setEstado"
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
              ¡No hay ningún turno pasado!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosSolicitados">
            <TarjetaTurno
              @ejecutarFuncion="setEstado"
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
              ¡No hay ningún turno pendiente!
            </div>
          </q-tab-panel>
          <q-tab-panel name="turnosConfirmados">
            <TarjetaTurno
              @ejecutarFuncion="setEstado"
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
              ¡No hay ningún turno confirmado!
            </div>
          </q-tab-panel>
        </q-tab-panels>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormTurnoVet @registrarPerro="registrarPerro" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref, computed  } from "vue";
import TarjetaTurno from "./tarjetas/TarjetaTurno.vue";
import FormTurnoVet from "./formularios/formTurnoVeterinario.vue";
import { useStore } from "../pinia/store.js";
import { api } from "src/boot/axios";
import { checkToken } from "src/functions/check.js";

export default defineComponent({
  name: "PaginaAdministrarTurnos",
  components: {
    TarjetaTurno,
    FormTurnoVet,
  },
  setup() {
    const mostrarPopup = ref("false");
    const tab = ref("turnosConfirmados");
    const listaTurnos = ref([]);

    const setEstado = async(data) => {
      console.log("entre setEstado")
      await api
      .post("/turno/setEstado", data)
      .then((response)=>{
        console.log(response.data)
      })
      .catch((error) => {
          console.log(error);
        })
    }

    const rol = useStore().rol;
    return {
      tab,
      rol,
      listaTurnos,
      mostrarPopup,
      setEstado,
    };
  },
  methods: {
    async loadTurnos(estado) {
      await api
        .post("/turno/getTurnosEstado", {
          estado: estado,
        })
        .then((response) => {
          console.log("respuesta: ", response.data);
          this.listaTurnos = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async loadTurnosFecha(estado) {
      await api
      .post("/turno/getTurnosEstado", {
          estado: 'Confirmado',
        })
        .then((response) => {
          if (estado === 'Confirmado') {
            this.listaTurnos = response.data.filter((turno) =>
              (new Date()) <= new Date(turno.FECHA)
            );
          } else {
            this.listaTurnos = response.data.filter((turno) =>
              (new Date()) >= new Date(turno.FECHA)
            );
          }
        })
        .catch((error) => {
          console.log(error);
        });
    }
  },
  mounted() {
    checkToken();
    this.loadTurnosFecha("Confirmado");
  },
});
</script>
