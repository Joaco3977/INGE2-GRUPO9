<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div class="text-center text-h4 text-primary q-py-md">PASEADORES</div>

      <q-btn
        v-show="rol == 2"
        color="accent"
        @click="abrirForm = true"
        class="self-end q-mr-md fixed-top-right q-mt-xl q-mr-lg "
        style="width: 15em"
      >
        <div class="textoBoton">Agregar paseador</div>
      </q-btn>
    <q-separator />

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 86vh"
      class="bg-white"
    >
      <div class="full-width row wrap justify-center">
        <TarjetaPaseador @ejecutarFuncion="eliminarPaseador"
          class="q-px-sm col-stretch"
          v-for="paseador in paseadores"
          :rol="rol"
          :key="paseador.DNI"
          :dni="paseador.DNI"
          :nombre="paseador.NOMBREAPELLIDO"
          :zona="paseador.ZONA"
          :dias="paseador.DIAS"
          :horario="paseador.HORARIO"
          :contacto="paseador.MAIL"
          :comentario="paseador.COMENTARIO"
        />


      </div>
    </q-scroll-area>

    <q-dialog persistent v-model="abrirForm" class="">
      <formPaseador />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, watch } from "vue";
import { ref } from "vue";
import TarjetaPaseador from "./tarjetas/TarjetaPaseador.vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import formPaseador from "./formularios/formPaseador.vue";

export default defineComponent({
  name: "PaginaPaseadores",
  components: {
    TarjetaPaseador,
    formPaseador,
  },
  setup() {
    const paseadores = ref([]);
    const rol = useStore().rol;

    const loadPaseadores = async () => {
      try {
        const response = await api.get("/paseador/getPaseadores");
        if (response !== false) {
          paseadores.value = response.data;
        }
      } catch (error) {
        console.error(error);
      }
    };

    async function eliminarPaseador (dni) {
      try {
        await api.post("paseador/deletePaseador", {
          dni: dni
        })
        loadPaseadores()
      } catch {
        console.error('NO SE PUDO ELIMINAR PASEADOR')
      }
    }

    return {
      eliminarPaseador,
      paseadores,
      rol,
      loadPaseadores,
      abrirForm: ref(false),
    };
  },
  mounted() {
    this.loadPaseadores();
  },
});
</script>
