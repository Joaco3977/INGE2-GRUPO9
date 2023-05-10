<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 50rem"
    >
      <q-card-section horizontal>
        <q-img class="col-5 q-pb-none" fit="cover" src="https://cdn.quasar.dev/img/parallax2.jpg" />

        <q-card-section class="column col-7 justify-start">
          <div class="text-h6 text-uppercase text-bold q-pr-sm q-pb-xs">
            {{ nombre }}
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Raza:</div>
            <div>{{ raza }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Tamaño:</div>
            <div>{{ tamanio }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Edad:</div>
            <div>{{ edad }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
            <div>{{ sexo }}</div>
          </div>
          <q-separator class="q-mt-xs" dark />
          <q-card-actions class="row justify-end items-center">
            <q-btn flat v-if="rol >= 1" class="textoBoton">
              Ver historial
            </q-btn>
            <q-btn flat v-if="rol >= 1" class="textoBoton">
              Editar datos
            </q-btn>
            <q-btn flat v-if="rol >= 1" class="textoBoton">
              Eliminar
            </q-btn>
          </q-card-actions>
        </q-card-section>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaPerro",
  components: {},
  props: {
    rol: String,
    nombre: String,
    edad: String,
    tamanio: String,
    sexo: String,
    raza: String,
    linkImg: String
  },
  setup() {

  },
  methods: {
    
  },
  mounted() {},
});
</script>
