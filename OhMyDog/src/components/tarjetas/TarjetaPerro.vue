<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 60rem"
    >
      <q-card-section horizontal>
        <q-img class="col-5 q-pb-none" fit="cover" src="https://www.giantfreakinrobot.com/wp-content/uploads/2021/12/scoob.jpeg" />

        <q-card-section class="column col-7 justify-between">
          <div class="">
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
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Peso:</div>
            <div>{{ peso }} kg</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Edad:</div>
            <div>{{ edad }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
            <div>{{ sexo }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Color:</div>
            <div>{{ color }}</div>
          </div>
          <q-separator class="q-mt-xs" dark />
          </div>

          <q-card-actions class="row justify-end items-center self-end">
            <!-- <q-btn flat v-if="rol >= 1" class="textoBoton">
              Ver historial
            </q-btn> -->
            <q-btn flat v-if="rol > 1" class="textoBoton">
              Editar datos
            </q-btn>
            <q-btn @click="eliminarPerro(nombre)" flat v-if="rol >= 1" class="textoBoton">
              Eliminar
            </q-btn>
          </q-card-actions>
        </q-card-section>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { api } from '../../boot/axios.js'

export default defineComponent({
  name: "TarjetaPerro",
  components: {},
  props: {
    rol: String,
    nombre: String,
    nacimiento: Date,
    tamanio: String,
    sexo: String,
    raza: String,
    peso: String,
    color: String,
    linkImg: String,
    foto: Image,
  },
  setup(props) {
    
    const fechaNacimiento = new Date(props.nacimiento);
    const fechaHoy = new Date();

    const anios = fechaHoy.getFullYear() - fechaNacimiento.getFullYear();
    const meses = fechaHoy.getMonth() - fechaNacimiento.getMonth();
    const dias = fechaHoy.getDate() - fechaNacimiento.getDate();

    // Adjust for negative values
    if (meses < 0 || (meses === 0 && dias < 0)) {
      anios--;
    }

    // Calculate the difference in months
    const mesesAbs =
      fechaHoy.getFullYear() * 12 +
      fechaHoy.getMonth() -
      (fechaNacimiento.getFullYear() * 12 + fechaNacimiento.getMonth());
    const aniosMeses = Math.floor(mesesAbs / 12);
    const mesesRestantes = mesesAbs % 12;

    // Calculate the remaining days
    const fechaDeReferencia = new Date(
      fechaNacimiento.getFullYear() + aniosMeses,
      fechaNacimiento.getMonth() + mesesRestantes,
      fechaNacimiento.getDate()
    );
    const diferenciaEnDias = Math.floor(
      (fechaHoy - fechaDeReferencia) / (24 * 60 * 60 * 1000)
    );

    const edadAnios = anios > 0 ? `${anios} años` : "";
    const edadMeses = aniosMeses > 0 ? `${aniosMeses} meses` : "";
    const edadDias = diferenciaEnDias > 0 ? `${diferenciaEnDias} días` : "";

    const edad = `${edadAnios} ${edadMeses} ${edadDias}`.trim();

    return {
      edad
    }
  },
  methods: {
    eliminarPerro(nombre) {
      this.$emit('eliminarPerro', nombre)
    }
  },
  mounted() {

  },
});
</script>
