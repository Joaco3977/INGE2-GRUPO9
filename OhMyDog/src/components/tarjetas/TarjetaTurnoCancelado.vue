<template>
    <!-- Todo el contenido tiene que estar adentro de un div -->
    <!-- Pueden usar componentes dentro de este componente -->
    <div class="" style="width: full%; max-height: 97vh">
      <q-card flat

        class="my-card bg-white text-white q-ma-md full-width q-mx-xl"      
      >
      <q-separator/>
      <q-card-section class="column">
        <div class="row">
              <div class="textoTituloPosteo text-primary q-pr-sm q-pb-xs"> Servicio:</div>
              <div class="text-primary" > {{fecha}} {{hora}}</div>
            </div>
        <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs text-primary"> Perro:</div>
              <div class="text-primary" >{{ nombrePerro }}</div>
            </div>
        <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs text-primary"> Servicio:</div>
              <div class="text-primary" >{{ nombreServicio }}</div>
            </div>
        
      </q-card-section>
      <q-separator/>
       
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
    nombrePerro: String,
    nombreServicio:String,
    fecha: String,
    hora:String,
  },
  data() {
    return {};
  },
  methods: {
    },
  },
);
</script>