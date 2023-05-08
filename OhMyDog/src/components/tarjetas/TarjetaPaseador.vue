<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card flat class="my-card bg-primary text-white q-ma-md" style="width: 38vw">
      <q-card-section v-if="rol == 2 ">
         <div class="row justify-end full-width">
          <q-btn class="q-ml-md" color="accent" >  <div> Editar datos  </div> </q-btn>
          <q-btn  class="q-ml-md" color="accent" >  <div> Eliminar paseador</div> </q-btn>
        </div>
      </q-card-section>
      <q-card-section>
        <!-- Contenido -->
        <div class="column">
          <div class="row items-baseline">
            <q-icon name="ion-walk" size="1.6rem" />
            <div class="textoTituloTarjeta q-pb-md">{{ nombre }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">
              Zona de trabajo:
            </div>
            <div>{{ zona }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">
              Días disponibles:
            </div>
            <div>{{ dias }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Horarios:</div>
            <div>{{ horario }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Contacto:</div>
            <div>{{ contacto }}</div>
          </div>
        </div>
      </q-card-section>

      <q-separator dark />
      <q-card-section v-if="comentario != ''" class="bg-info">
        <div class="row">
          <div class="textoTituloPosteo q-pr-sm q-pb-xs">
            Información adicional:
          </div>
          <div>{{ comentario }}</div>
        </div>
      </q-card-section>

      <!-- Acciones -->
      <q-separator dark />
      <q-card-actions class="column justify-around">
        <q-btn
          flat
          class="textoBoton"
          v-if="servicio == 'paseadores'"
          :href="convertirContacto()"
          target="_blank"
        >
          Contactar dueño
        </q-btn>
        
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
    zona: String,
    dias: String,
    horario: String,
    contacto: String,
    comentario: String,
  },
  data() {
    return {};
  },
  methods: {
    convertirContacto() {
      let cont = "";
      if (this.contacto.includes("@")) {
        cont =
          "mailto:" +
          this.contacto +
          "?subject=Contacto%20desde%20OhMyDog%20-%20Paseo%20de%20perro";
      } else {
        cont =
          "https://api.whatsapp.com/send?phone=" +
          this.contacto +
          "&text=Contacto%20desde%20OhMyDog%20por%20paseador20de%20perro";
      }
      console.log(cont);
      return cont;
    },
  },
  mounted() {},
});
</script>
