<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-py-md">PASEADORES</div>

    <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

    <!-- -->
    <q-card flat class="column">
      <q-btn v-if="rol == 2 " color="accent" class="q-ma-md self-end" style="width: 15em">
        <div class="textoBoton">Agregar paseador</div>
      </q-btn>
      <q-separator />

          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 70vh"
            class="bg-white"
          >
            <div class="full-width row items-center">
              <!-- Posteos de perros ACÁ DEBERÍA ENTRAR LA INFO DE PERROS DE LA BASE DE DATOS -->

              <TarjetaPaseador
              v-for="(paseador, zona) in paseadores" :key="zona"
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
    <!-- -->

    <!-- los veterinarios tendrían una vista, los clientes otras Y LOS VISITANTES OTRAS??

      ahora estoy pensando en texto...
      - visitante: ver
      - cliente: ver, subir, ver subidos ( nota: usar dos columnas )
      - vet: ver editar -->

    <!-- Hasta acá :)  -->
  </div>
</template>

<script>
import { defineComponent, reactive } from "vue";
import { ref } from "vue";
import TarjetaPaseador from "./tarjetas/TarjetaPaseador.vue";
import { api } from '../boot/axios.js'

export default defineComponent({
  name: "PaginaPaseadores",
  components: {
    TarjetaPaseador
  },
  setup() {
    const paseadores = reactive([]);

    const loadPaseadores = async () => {
      try {
        const response = await api.get("/paseador/getPaseadores")
        if (response !== false) {
          paseadores.value = response.data;
          console.log('Paseadores: ', paseadores)
        }
      } catch (error) {
        console.error(error);
      }
    };

    return {
      paseadores,
      loadPaseadores: ref(loadPaseadores),
    };
  },
  mounted() {
    this.loadPaseadores()
  }
});
</script>
