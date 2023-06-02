<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->

  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        MIS PERROS
      </div>
    </div>
    <q-card stretch flat class="bg-white full-width full-height column">
      <q-separator></q-separator>

          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 88vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify justify-center">
              <TarjetaPerro @eliminarPerro="eliminarPerro" class="q-py-sm"
                v-for="perro of perrosDatos"
                :key="perro.ID"
                :rol="rol"
                :foto="perro.FOTO"
                :nombre="perro.NOMBRE"
                :nacimiento="perro.NACIMIENTO"
                :peso="perro.PESO"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :raza="perro.RAZA"
                :color="perro.COLOR"
                linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
              />
            </div>
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="perrosDatos.length === 0"
            >
              ¡No tenés ningún perro!
            </div>
          </q-scroll-area>

    </q-card>


  </div>
</template>

<style>
.paraform {
  background-color: #fff;
}
</style>

<script>
import { defineComponent, ref } from "vue";
import TarjetaPerro from "./tarjetas/TarjetaPerro.vue";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";
import { checkToken } from "../functions/check.js"

export default defineComponent({
  name: "PaginaPerros",
  components: {
    TarjetaPerro,
  },
  setup() {
    const perrosDatos = ref([]);
    const rol = useStore().rol

    const loadPerrosPropios = async () => {
      try {
        const response = await api.post("/perro/getPerrosPropios",{ dni : useStore().dni })
        perrosDatos.value = response.data;
      }
      catch (error) {
        console.error(error);
      }
    };

    async function eliminarPerro (nombre)  {
      console.log(nombre);
      try {
        const response = await api.post("/perro/deletePerroPropio", {
          datos: {
            nombre: nombre,
            dnicliente: useStore().dni,
          },
        });
        loadPerrosPropios();
      } catch (error) {
        console.error(error);
      }
    };

    return {
      loadPerrosPropios,
      rol,
      perrosDatos,
      eliminarPerro
    };
  },
  mounted() {
    checkToken()
    this.loadPerrosPropios()
  },
});
</script>
