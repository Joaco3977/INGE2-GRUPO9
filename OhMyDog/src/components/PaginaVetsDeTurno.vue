<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        VETERINARIAS DE TURNO
      </div>
      <q-btn
        v-if="rol === 2 && tab === 'listadoVets'"
        @click="agregarVetDeTurno = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Agregar veterinaria al listado</div>
      </q-btn>
      <q-btn
        v-if="rol === 2 && tab === 'vetsTurno'"
        @click="registrarVetDeTurno = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Registrar nueva veterinaria</div>
      </q-btn>
    </div>

    <q-card stretch flat class="bg-white full-width full-height column no-wrap">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md full-width"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <q-tab
          @click="loadListadoVetsTurno"
          name="listadoVets"
          label="Listado de veterinarias de turno"
        />
        <q-tab
          v-if="rol === 2"
          @click="loadVetsTurno"
          name="vetsTurno"
          label="Veterinarias registradas"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated class="full-width">
        <q-tab-panel name="listadoVets">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="listadoVetsTurno.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaVeterinaria
              class="q-px-sm col-stretch"
              v-for="vet in listadoVetsTurno"
              :key="vet.ID"
              :id="vet.ID"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡No hay ninguna veterinaria de turno!
          </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel name="vetsTurno" class="column">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="vetsTurnoRegistradas.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaVeterinaria
              class="q-px-sm col-stretch"
              v-for="vet in vetsTurnoRegistradas"
              :key="vet.ID"
              :id="vet.ID"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡Todavía se registro ninguna veterinaria de turno!
          </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="agregarVetDeTurno">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Agregar veterinaria al listado</div>
        </q-card-section>

        <q-select
            v-model="perroElegido"
            :options="opcionPerros"
            class="q-px-xl"
            label="Perro"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            @click="registrarPerroCruza(perroElegido.value.ID, fechaCelo)"
            :disabled="!camposValidos"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Volver" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>
<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import TarjetaVeterinaria from "./tarjetas/TarjetaVeterinaria.vue";

export default defineComponent({
  name: "PaginaVetsDeTurno",
  components: {
    TarjetaVeterinaria,
  },
  setup() {
    const listadoVetsTurno = ref([]);
    const vetsTurnoRegistradas = ref([])

    const tab = ref("listadoVets");

    const rol = useStore().rol;
    const agregarVetDeTurno = ref(false);
    const registrarVetDeTurno = ref(false);

    const vetElegida = ref({ label: "", value: '' })

    const nombreVetsTurno = ref([]);

    const opcionVetsTurno = ref([])

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const loadMisDisponiblesCruzar = async () => {

    }

    const loadPerrosRecomendados = async () => {

    };

    const loadPerrosCruza = async () => {

    };

    const registrarVetTurno = async (id) => {

    };

    const eliminarVetTurno = async (data) => {

    }

    return {
      tab,
      rol,
      listadoVetsTurno,
      vetsTurnoRegistradas,
      agregarVetDeTurno,
      registrarVetDeTurno,
      vetElegida,
      nombreVetsTurno,
      opcionVetsTurno
    };
  },
  mounted() {
  },
  computed: {
    camposValidos () {
      return this.perroElegido.label !== ''
    }
  }
});
</script>
