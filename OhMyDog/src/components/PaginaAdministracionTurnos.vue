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
        dense flat
        class="text-grey q-pt-md"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
    >
      <q-tab @click="loadTurnos('Cancelados')"
        name="turnosCancelados"
        label="Cancelados"/>
      <q-tab @click="loadTurnos('Pasados')"
        name="turnosPasados"
        label="Pasados"/>
      <q-tab @click="loadTurnos('Solicitado')"
        name="turnosSolicitados"
        label="Solicitados" />
      <q-tab @click="loadTurnos('Confirmado')"
        name="turnosConfirmados"
        label="Confirmados"/>
      
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
          <TarjetaTurnoCancelado
            v-for="item in 5" :key="item"
            :nombrePerro= 'como'
            :fecha= 'fecha'
            :hora='hora'
            :nombreServicio='Consulta' />
        </q-tab-panel>
        <q-tab-panel name="turnosPasados">
          <TarjetaTurno
            v-for="item in 5" :key="item"
            :rol="rol"
            :state="state"
            :nombrePerro= 'como'
            :fecha= 'fecha'
            :hora='hora'
            :nombreServicio='Consulta' />
        </q-tab-panel>
        <q-tab-panel name="turnosSolicitados">
          <TarjetaTurno
            v-for="item in 5" :key="item"
            :rol="rol"
            :state="state"
            :nombrePerro= 'como'
            :fecha= 'fecha'
            :hora='hora'
            :nombreServicio='Consulta' />
        </q-tab-panel>
        <q-tab-panel name="turnosConfirmados">
          <TarjetaTurno
            v-for="item in 5" :key="item"
            :rol="rol"
            :state="state"
            :nombrePerro= 'como'
            :fecha= 'fecha'
            :hora='hora'
            :nombreServicio='Consulta' />
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
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaTurno from './tarjetas/TarjetaTurno.vue';
    import TarjetaTurnoCancelado from './tarjetas/TarjetaTurnoCancelado.vue';
  import FormTurnoVet from './formularios/formTurnoVeterinario.vue'
  import { useStore } from "../pinia/store.js";
  import { api } from 'src/boot/axios';
  import { checkToken } from 'src/functions/check.js';

  export default defineComponent({
  name: 'PaginaAdministrarTurnos',
  components: {
    TarjetaTurno,
    TarjetaTurnoCancelado,
    FormTurnoVet,
    },
    setup(){
      const mostrarPopup = ref("false");
      const tab = ref("turnosConfirmados");
      const listaTurnos = ref([])
      const rol =useStore().rol;
      return{
        tab,
        rol,
        listaTurnos,
        mostrarPopup
      }
    },
    methods: {
      async loadTurnos(estado) {
        await api.post("/turno/getTurnosEstado", {
          estado: estado
        })
        .then((response) => {
          console.log(response.data)
          this.listaTurnos.value = response.data
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
