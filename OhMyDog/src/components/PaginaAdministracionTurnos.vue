<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">

      <div class="text-center text-h4 text-primary "> ADMINISTRAR TURNOS </div>
      <div class="text-center text-h6 text-primary "> Hola! Soy el componente "ADMINISTRAR TURNOS" EDITAME </div>
    <q-card flat class="column">
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->
      <q-btn
          v-if="rol === 2"
          color="accent"
          class="q-ma-md q-mr-xl self-end"
          style="width: 20em"
        >
          <div class="textoBoton">Crear Turno</div>
        </q-btn>

      <q-tabs
          v-model="tab"
          dense
          class="text-grey q-pt-md"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
        <q-tab @click="loadTurnos('Confirmado')"
            name="turnosConfirmados"
            label="Turnos Confirmados"
          />
        <q-tab @click="loadTurnos('Pendiente')"
            name="turnosPendientes"
            label="Turnos Pendientes"
          />
        </q-tabs>
        <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 70vh"
        class="bg-white"
        >
        <q-separator/>
        <q-card flat>
          <q-tab-panels v-model="tab" animated>
            <q-tab-panel name="turnosConfirmados">
              <q-scroll-area
                :thumb-style="thumbStyle"
                :bar-style="barStyle"
                style="height: 75vh; width: 100%"
                class="bg-white full-width"
              >
              <!--
                <div class="full-width row items-justify">
                  <TarjetaTurno

                  />-->
              </q-scroll-area>
            </q-tab-panel>

            <q-tab-panel name="turnosPendientes">
              <q-scroll-area
                :thumb-style="thumbStyle"
                :bar-style="barStyle"
                style="height: 75vh; width: 100%"
                class="bg-white full-width"
              >
              <!--
                <div class="full-width row items-justify">
                  <TarjetaTurno

                  />-->
              </q-scroll-area>
            </q-tab-panel>
          </q-tab-panels>
        </q-card>
      </q-scroll-area>
    </q-card>
  </div>

  </template>

  <script>
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaTurno from './tarjetas/TarjetaTurno.vue';
  import { useStore } from "../pinia/store.js";
  import { api } from 'src/boot/axios';
  import { checkToken } from 'src/functions/check.js';

  export default defineComponent({
  name: 'PaginaAdministrarTurnos',
  components: {
    //TarjetaTurno,
    },
    setup(){
      const tab = ref("turnosConfirmados");
      const store = useStore();
      const rol =useStore().rol;
      return{
        tab,
        rol,
      }
    },
    methods: {
      async loadTurnos(estado) {
        await api.post("/turno/getTurnosEstado", {
          estado: estado
        })
        .then((response) => {
          console.log(response.data)
        })
        .catch((error) => {
          console.log(error)
        })
      }
    },
    mounted() {
      checkToken()
      this.loadTurnos('Confirmado')
    }
  })
  </script>
