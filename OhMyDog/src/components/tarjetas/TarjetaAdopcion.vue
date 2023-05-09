<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card flat class="my-card bg-primary text-white q-ma-md" style="width: 23vw">
      <q-card-section v-if="servicio == 'misPerros' || rol == 2">
         <div class="row justify-end full-width">
          <q-btn v-if="servicio == 'misPerros'" class="" color="accent" >  <div>Editar datos</div> </q-btn>
          <q-btn  class="q-ml-sm" color="accent" >  <div>Eliminar</div> </q-btn>
        </div>
      </q-card-section>
      <q-card-section>
        <!-- Contenido --> 
        <div class="column">
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Nombre:</div>
            <div>  {{nombre}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Tamaño:</div>
            <div> {{tamanio}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Edad:</div>
            <div>  {{edad}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Sexo:</div>
            <div> {{sexo }} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Telefono:</div>
            <div> {{telefono}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Tamaño:</div>
            <div> {{tamanio}} </div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Contacto:</div>
            <div>  {{contacto}} </div>
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
        <q-btn flat v-if="servicio == 'misPerros' "
          class="textoBoton" 
          > Marcar como adoptado </q-btn>
        <q-btn flat v-else
          class="textoBoton" 
          :href=convertirContacto()
          target="_blank"
          > Contactar dueño </q-btn>
      </q-card-actions>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaAdopcion",
  components: {},
  props: {
    rol: String,
    servicio: String,
    nombre: String,
    edad: String,
    tamanio: String,
    sexo: String,
    telefono: String,
    mail: String,
    comentario: String,
  },
  data(){
    return{
      contactoCliente: '',
    }
  },
  methods: {
    convertirContacto(){
      let cont = ''
      if(this.contacto.includes("@")){
        cont = 'mailto:' + this.mail + '?subject=Contacto%20desde%20OhMyDog%20-%20Adoptar%20' + this.nombre;
      } else {
        cont = 'https://api.whatsapp.com/send?phone=' + this.telefono +  '&text=Contacto%20desde%20OhMyDog%20por%20adopción%20de%20' + this.nombre
      }
      console.log(cont)
      return cont;
    }
  },
  mounted(){
    
  }, 
});
</script>
