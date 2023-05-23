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
        @click="mostrarPopupM"
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
        dense flat
        class="text-grey q-pt-md"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
    >
      <q-tab @click="loadTurnosPropios('Cancelados')"
        name="turnosCancelados"
        label="Cancelados"/>
      <q-tab @click="loadTurnosPropios('Pasados')"
        name="turnosPasados"
        label="Pasados"/>
      <q-tab @click="loadTurnosPropios('Solicitado')"
        name="turnosSolicitados"
        label="Solicitados" />
      <q-tab @click="loadTurnosPropios('Confirmado')"
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
</div>

</template>

<script>

  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaTurno from './tarjetas/TarjetaTurno.vue';
    import TarjetaTurnoCancelado from './tarjetas/TarjetaTurnoCancelado.vue';
  import { useStore } from "../pinia/store.js";
  import { checkToken } from 'src/functions/check.js';
  import { api } from 'src/boot/axios';


  export default defineComponent({
  name: 'PaginaTurnos',
  components: {
    TarjetaTurno,
    TarjetaTurnoCancelado,
    },
    setup(){
      const tab = ref("turnosConfirmados");
      const listaTurnos = ref ([])
      const rol =useStore().rol;
      return{
        tab,
        rol,
        listaTurnos,
      }
    },
    methods: {
      async loadTurnosPropios(estado) {
        await api.post('/turno/getTurnosDni', {
          dni: useStore().dni,
          estado: estado,
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
      this.loadTurnosPropios('Solicitado')
    }
  })
</script>
