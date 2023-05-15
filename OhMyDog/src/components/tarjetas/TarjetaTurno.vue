<template>
    <!-- Todo el contenido tiene que estar adentro de un div -->
    <!-- Pueden usar componentes dentro de este componente -->
    <div class="bg-white" style="width: full; max-height: 97vh">
      <q-card
        flat
        class="my-card bg-primary text-white q-ma-md full-width"      
      >
  
      <!-- style="min-width: 20rem; max-width: 25rem" -->
  
      
        <q-card-section v-if="rol == 2">
          <div class="row justify-end full-width">
            <q-btn v-if="rol < 0" class="q-ml-md" color="accent">
              <div>Cancelar Turno</div>
            </q-btn>
            <q-btn v-if=" rol == 2 && state == 'Pendiente' " class="q-ml-md" color="accent">
              <div>Confirmar</div>
            </q-btn>
            <q-btn v-if=" rol == 2 && state == 'Pendiente' " class="q-ml-md" color="accent">
              <div>Rechazar</div>
            </q-btn>
          </div>
        </q-card-section>
        <q-card-section>
          <!-- Contenido -->
        </q-card-section>
      </q-card>
    </div>
  </template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaPaseador",
  components: {},
  props: {
    rol: String,
    state:String,
  },
  data() {
    return {};
  },
  methods: {
    },
  },
);
</script>