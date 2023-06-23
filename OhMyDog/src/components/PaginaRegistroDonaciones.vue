<template>
  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        REGISTRO DE DONACIONES
      </div>
    </div>

      <q-separator></q-separator>

      <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 86vh"
      class="bg-white"
    >
      <div
        v-if="entradasDonaciones.length > 0"
        class="full-width row wrap justify-center"
      >
        <TarjetaRegistroDonacion
          class="q-px-sm col-stretch"
          v-for="entrada in entradasDonaciones"
          @loadRegistrosDonacion="loadRegistrosDonacion"
          :key="entrada.ID"
          :id="entrada.ID"
          :fecha="entrada.FECHA"
          :estado="entrada.ESTADO"
          :nombre="entrada.NOMBRECAMPANIA"
          :dniCliente="entrada.DNICLIENTE"
          :cantidad="entrada.CANTIDAD"
        />
      </div>
      <div
        class="row textoNoItems justify-center full-height content-center q-pa-xl"
        v-else
      >
        ¡Todavia no se realizo ninguna donacion!
      </div>
    </q-scroll-area>
  </div>
</template>

<script>
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaRegistroDonacion from '../components/tarjetas/TarjetaRegistroDonacion.vue'
  import { checkToken } from "src/functions/check.js";
  import { api } from '../boot/axios.js'

  export default defineComponent({
  name: 'PaginaRegistroDonaciones',
  components: {
    TarjetaRegistroDonacion
  },
  setup() {
    const entradasDonaciones = ref([]);

    const loadRegistrosDonacion = async () => {
      await api.get('/donacion/getRegistrosDonacion')
      .then((response) => {
        entradasDonaciones.value = response.data
      })
      .catch((error) => {
        console.log(error)
      })
    }

    return {
      entradasDonaciones,
      loadRegistrosDonacion,
    }
  },
  mounted() {
    checkToken();
    this.loadRegistrosDonacion();
  },
  })
</script>
