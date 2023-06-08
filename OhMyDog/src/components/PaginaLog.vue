<template>
  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        LOG
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
        v-if="entradasLog.length > 0"
        class="full-width row wrap justify-center"
      >
        <TarjetaLog
          class="q-px-sm col-stretch"
          v-for="entrada in entradasLog"
          :key="entrada.ID"
          :id="entrada.ID"
          :fecha="entrada.FECHA"
          :descripcion="entrada.DESCRIPCION"
        />
      </div>
      <div
        class="row textoNoItems justify-center full-height content-center q-pa-xl"
        v-else
      >
        ¡No hay ningun Log!
      </div>
    </q-scroll-area>
  </div>
</template>

<script>
  import { defineComponent } from 'vue'
  import { ref } from 'vue'
  import TarjetaLog from '../components/tarjetas/TarjetaLog.vue'
  import { checkToken } from "src/functions/check.js";
  import { api } from '../boot/axios.js'

  export default defineComponent({
  name: 'PaginaLog',
  components: {
    TarjetaLog
  },
  setup() {
    const entradasLog = ref([]);

    const loadLog = async () => {
      await api.get('/log/getLog')
      .then((response) => {
        entradasLog.value = response.data
      })
      .catch((error) => {
        console.log(error)
      })
    }

    return {
      entradasLog,
      loadLog,
    }
  },
  mounted() {
    checkToken();
    this.loadLog();
  },
  })
</script>
