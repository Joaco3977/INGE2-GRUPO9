<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card class="my-card bg-primary text-white q-ma-md" style="width: 22vw">
      <q-img
        src="https://media.sketchfab.com/models/060d500bf27a4b9ab242ea67d1baad76/thumbnails/a55c7d7c89ff4725b76be6eb3fe3f1f2/9f9a4b4fba9e40838d0acb8e34773196.jpeg"
      ></q-img>
      <q-card-section>
        <!-- Contenido -->
        <div class="column">
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> DNI:</div>
            <div>  {{dni}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Nombre y Apellido:</div>
            <div> {{nombreaApellido}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Mail:</div>
            <div> {{mail}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Telefono:</div>
            <div>  {{telefono}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Direccion:</div>
            <div>  {{direccion}} </div>
          </div>

        </div>
      </q-card-section>
      <q-card-actions class="column items-center">
        <q-btn push class="textoBoton"  flat> Contactar </q-btn>
        <q-btn push class="textoBoton"  flat> Editar </q-btn>
        <q-btn push class="textoBoton"  flat> Eliminar </q-btn>
      </q-card-actions>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaCliente",
  components: {},
  props: {
    dni: String,
    nombreaApellido: String,
    mail: String,
    telefono: String,
    direccion: String,
  },
  setup() {
    return {};
  },
});
</script>
