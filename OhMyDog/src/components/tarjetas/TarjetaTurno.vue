<template>
    <!-- Todo el contenido tiene que estar adentro de un div -->
    <!-- Pueden usar componentes dentro de este componente -->
    <div class="bg-white" style="width: full; max-height: 97vh">
      <q-card
        flat
        class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"      
      >

      <q-card-section class="column">
        <div class="textoPerfil q-py-sm">
            {{ fecha }} {{ hora }}
        </div>
        <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Perro:</div>
              <div>{{ nombrePerro }}</div>
            </div>
        <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Servicio:</div>
              <div>{{ nombreServicio }}</div>
            </div>
      </q-card-section>
        <q-card-actions >
          <div class="row justify-end full-width q-pb-xs q-pr-sm">
            <q-btn flat v-if="rol > 0 && state != 'Pasado' " class="q-ml-md">
              <div>Cancelar Turno</div>
            </q-btn>
            <q-btn v-if=" rol == 2 && state == 'Pendiente' " class="q-ml-md" color="accent">
              <div>Confirmar</div>
            </q-btn>
            <q-btn v-if=" rol == 2 && state == 'Pendiente' " class="q-ml-md" color="accent">
              <div>Rechazar</div>
            </q-btn>
          </div>
        </q-card-actions>
        
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
    fecha: String,
    hora: String,
    nombrePerro: String,
    nombreServicio: String
  },
  data() {
    return {};
  },
  methods: {
    },
  },
);
</script>