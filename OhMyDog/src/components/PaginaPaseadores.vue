<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-py-md">PASEADORES</div>
    <q-card flat class="column">
      <q-btn v-if="rol == 2 " color="accent" @click="abrirForm = true" class="q-ma-md self-end" style="width: 15em">
        <div class="textoBoton">Agregar paseador</div>
      </q-btn>
      <q-separator />

          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 82vh"
            class="bg-white"
          >
            <div class="full-width row wrap justify-start">
              <TarjetaPaseador class="q-px-sm "
              v-for="paseador in paseadores"
                :rol="rol"
                :key="paseador.DNI"
                :nombre='paseador.NOMBREAPELLIDO'
                :zona='paseador.ZONA'
                :dias='paseador.DIAS'
                :horario='paseador.HORARIO'
                :contacto='paseador.MAIL'
                :comentario="paseador.COMENTARIO"
              />
            </div>
          </q-scroll-area>
    </q-card>

    <q-dialog persistent v-model="abrirForm" class="">
       <formPaseador /> 
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive } from "vue";
import { ref } from "vue";
import TarjetaPaseador from "./tarjetas/TarjetaPaseador.vue";
import { api } from '../boot/axios.js';
import { useStore } from '../pinia/store.js';
import formPaseador from './formularios/formPaseador.vue'

export default defineComponent({
  name: "PaginaPaseadores",
  components: {
    TarjetaPaseador,
    formPaseador,
  },
  setup() {
    const paseadores = ref ([]);
    const rol = useStore().rol

    const loadPaseadores = async () => {
      try {
        const response = await api.get("/paseador/getPaseadores")
        if (response !== false) {
          paseadores.value = response.data;
          console.log('Paseadores: ', paseadores.value)
        }
      } catch (error) {
        console.error(error);
      }
    };

    return {
      paseadores,
      rol,
      loadPaseadores: ref(loadPaseadores),

      abrirForm: ref(false),
    };
  },
  mounted() {
    this.loadPaseadores()
  }
});
</script>


  