<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card class="my-card bg-primary text-white q-ma-md" style="width: 22vw">
      <q-img v-if="servicio != 'adopciones' "
        src="https://media.sketchfab.com/models/060d500bf27a4b9ab242ea67d1baad76/thumbnails/a55c7d7c89ff4725b76be6eb3fe3f1f2/9f9a4b4fba9e40838d0acb8e34773196.jpeg"
      ></q-img>
      <q-card-section>
        <!-- Contenido --> 
        <div class="column">
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Nombre:</div>
            <div>  {{nombre}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Raza:</div>
            <div> {{raza}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Tamaño:</div>
            <div> {{tamanio}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Edad:</div>
            <div>  {{edad}} </div>
          </div>
          
        </div>
      </q-card-section>
      <q-separator dark />
      <q-card-section  v-if="comentario != '' " class="bg-info">
        <div class="column items-center">
            <div class="textoComentario" > 
              <b class="textoComillas"> " </b> 
              {{ comentario }}
              <b class="textoComillas"> " </b> 
            </div>
        </div>
      </q-card-section>
        <!-- Acciones -->
      <q-separator dark />
      <q-card-actions class="column items-center">
        <q-btn v-if="servicio == 'adopcionesPropias' " flat> ¡Adoptado! </q-btn>
        <q-btn v-if="servicio == 'adopcionesPropias' " flat> Eliminar perro</q-btn>
        <q-btn push class="textoBoton" v-if="servicio == 'adopciones' " flat> Contactar dueño </q-btn>
      </q-card-actions>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaPosteo",
  components: {},
  props: {
    rol: String,
    servicio: String,

    nombre: String,
    raza: String,
    edad: String,
    tamanio: String,
    comentario: String,
  },
  setup() {
    return {};
  },
});
</script>
