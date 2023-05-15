<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width"
      style="min-width: 20rem; max-width: 25rem"
    >

    <!-- style="min-width: 20rem; max-width: 25rem" -->


      <q-card-section v-if="rol == 2">
        <div class="row justify-end full-width">
          <q-btn class="q-ml-md" color="accent">
            <div>Editar datos</div>
          </q-btn>
          <q-btn @click="ejecutarFuncionPadre(dni)" class="q-ml-md" color="accent">
            <div>Eliminar paseador</div>
          </q-btn>
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
          <!--ACA IRIA LA TABLA DE LOS DIAS Y LOS HORARIOS-->
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
import { defineComponent, ref } from "vue";
import { api } from '../../boot/axios.js';
import { useStore  } from '../../pinia/store.js'

export default defineComponent({
  name: "TarjetaPaseador",
  components: { },
  props: {
    rol: String,
    dni: String,
    nombre: String,
    zona: String,
    disponibilidad: String,
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
      return cont;
    },
    ejecutarFuncionPadre(dni) {
      this.$emit('ejecutarFuncion', dni);
    }
  }
});
</script>
