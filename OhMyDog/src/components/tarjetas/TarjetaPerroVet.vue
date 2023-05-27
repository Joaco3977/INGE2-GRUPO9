<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <q-card
    flat
    class="my-card bg-primary text-white q-ma-md full-width"
    style="width: 55rem; max-width: 55rem; max-height: 40rem"
  >
    <q-tabs
      v-model="tab"
      dense
      class="text-white text-h5 text-bold q-py-xs full-width"
      active-color="white"
      indicator-color="secondary"
      align="justify"
      narrow-indicator
    >
      <q-tab name="datos" label="datos" />
      <q-tab name="turnos" label="turnos" />
    </q-tabs>

    <q-tab-panels v-model="tab" animated class="full-width">
      <q-tab-panel name="datos" class="bg-primary">
        <q-card-section horizontal>
          <q-img
            class="col-5 q-pb-none"
            fit="cover"
            src="https://shorturl.at/mnsL0"
          />

          <q-card-section class="column col-7 justify-between">
            <div class="">
              <div class="text-h5 text-uppercase text-bold q-pr-sm q-pb-sm">
                {{ perro.NOMBRE }}
              </div>
              <q-separator dark></q-separator>
              <div class="row q-pt-sm">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Raza:</div>
                <div>{{ perro.RAZA }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Tamaño:</div>
                <div>{{ perro.TAMANIO }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Peso:</div>
                <div>{{ perro.PESO }} kg</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Edad:</div>
                <div>{{ edad }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
                <div>{{ perro.SEXO }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Color:</div>
                <div>{{ perro.COLOR }}</div>
              </div>
              <q-separator class="q-mt-xs" dark />
            </div>

            <q-card-actions class="row justify-end items-center self-end">
              <!-- <q-btn flat v-if="rol >= 1" class="textoBoton">
              Ver historial
            </q-btn> 
          <q-btn flat class="textoBoton"> Editar datos </q-btn> -->
              <q-btn @click="eliminarPerro(nombre)" flat class="textoBoton">
                Eliminar
              </q-btn>
            </q-card-actions>
          </q-card-section>
        </q-card-section>
      </q-tab-panel>

      <q-tab-panel name="turnos" class="bg-primary">
        <div horizontal style="width: 55rem; max-width: 55rem; max-height: 40rem">
          <SubPaginaTurnos :nombrePerro="perro.NOMBRE" />
        </div>
      </q-tab-panel>
      
    </q-tab-panels>
  </q-card>
</template>

<script>
import { defineComponent, ref } from "vue";
import { api } from "../../boot/axios.js";
import SubPaginaTurnos from "../subPaginas/SubPaginaTurnos.vue";

export default defineComponent({
  name: "TarjetaPerroVet",
  components: {
    SubPaginaTurnos,
  },
  props: {
    rol: String,
    perro: {
      type: Object,
      required: true,
      default: () => ({ NOMBRE: "", TAMANIO: "" }), // Set a default empty value for the prop
    },
  },
  setup(props) {
    const tab = ref("datos");

    const fechaNacimiento = new Date(props.perro.NACIMIENTO);
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
      edad,
      tab,
    };
  },
  methods: {
    eliminarPerro(nombre) {
      this.$emit("eliminarPerro", nombre);
    },
  },
  mounted() {},
});
</script>
