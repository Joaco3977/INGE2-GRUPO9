<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        PASEADORES
      </div>
      <q-btn
        v-if="rol == 2"
        @click="abrirForm = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Agregar paseador</div>
      </q-btn>
    </div>

    <q-separator />

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 86vh"
      class="bg-white"
    >
      <div
        v-if="paseadores.length > 0"
        class="full-width row wrap justify-center"
      >
        <TarjetaPaseador
          @ejecutarFuncion="eliminarPaseador"
          class="q-px-sm col-stretch"
          v-for="paseador in paseadores"
          :rol="rol"
          :key="paseador.DNI"
          :dni="paseador.DNI"
          :nombre="paseador.NOMBREAPELLIDO"
          :zona="paseador.ZONA"
          :disponibilidad="paseador.DISPONIBILIDAD"
          :mail="paseador.MAIL"
          :comentario="paseador.COMENTARIO"
        />
      </div>
      <div
        class="row textoNoItems justify-center full-height content-center q-pa-xl"
        v-else
      >
        ¡Todavía no tenemos ningún paseador en el sitio!
      </div>
    </q-scroll-area>

    <q-dialog persistent v-model="abrirForm" class="">
      <formPaseador @registrarPaseador="registrarPaseador" :dniPaseadores="dniPaseadores" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
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
    const abrirForm = ref(false);

    const dniPaseadores = ref([]);

    const loadPaseadores = async () => {
      try {
        const response = await api.get("/paseador/getPaseadores");
        if (response !== false) {
          paseadores.value = response.data;
          dniPaseadores.value = response.data.map((paseador) => paseador.DNI);
          console.log("Los paseadores: ", dniPaseadores.value);
        }
      } catch (error) {
        console.error(error);
      }
    };

    const registrarPaseador = async (paseador) => {
      try {
        await api.post("/paseador/addPaseador", {
          dniVet: useStore().dni,
          paseador: paseador,
        });
        abrirForm.value = false;
        loadPaseadores();
      } catch (error) {
        console.error(error);
      }
    };

    async function eliminarPaseador(dni) {
      try {
        await api.post("paseador/deletePaseador", {
          dniVet: useStore().dni,
          dni: dni,
        });
        loadPaseadores();
      } catch {
        console.error("NO SE PUDO ELIMINAR PASEADOR");
      }
    }

    return {
      eliminarPaseador,
      paseadores,
      dniPaseadores,
      rol,
      loadPaseadores,
      registrarPaseador,
      abrirForm,
    };
  },
  mounted() {
    this.loadPaseadores();
  },
});
</script>
