<template>
<!-- Todo el contenido tiene que estar adentro de un div -->
<!-- Pueden usar componentes dentro de este componente -->
<div class="bg-white" style="width: full; max-height: 90vh">

    <div class="text-center text-h4 text-primary "> MIS TURNOS </div>
  <q-card>
    <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->
    <q-btn
        color="accent"
        class="q-ma-md q-mr-xl self-end"
        style="width: 20em"
      >
        <div class="textoBoton">Pedir Turno</div>
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
      <q-tab 
        name="turnosSolicitados" 
        label="Turnos Solicitados" />
      <q-tab
        name="turnosConfirmados"
        label="Turnos Confirmados"/>
    </q-tabs>

      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated>
        <q-tab-panel name="turnos">
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
</div>

</template>

<script>
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaTurno from './tarjetas/TarjetaTurno.vue';
  import { useStore } from "../pinia/store.js";
  export default defineComponent({
  name: 'PaginaTurnos',
  components: {
    //TarjetaTurno,
    },
    setup(){
      const tab = ref("turnosSolicitados");
      const store = useStore();
      const rol =useStore().rol;
      return{
        tab,
        rol,
      }
    }
  })
</script>
