<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        DONACIONES
      </div>
      <q-btn
        v-if="rol == 2"
        @click="abrirForm = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Agregar campaña</div>
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
        v-if="donaciones.length > 0"
        class="full-width row wrap justify-center"
      >
        <TarjetaDonacion
          @eliminarDonacion="eliminarDonacion"
          @loadDonaciones="loadDonaciones"
          class="q-px-sm col-stretch"
          :nombreDonaciones="nombreDonaciones"
          v-for="donacion in donaciones"
          :key="donacion.ID"
          :rol="rol"
          :id="donacion.ID"
          :nombre="donacion.NOMBRE"
          :descripcion="donacion.DESCRIPCION"
          :link="donacion.LINK"
        />
      </div>
      <div
        class="row textoNoItems justify-center full-height content-center q-pa-xl"
        v-else
      >
        ¡Todavía no tenemos ninguna donación en el sitio!
      </div>
    </q-scroll-area>

    <q-dialog persistent v-model="abrirForm" class="">
      <formDonacion @registrarDonacion="registrarDonacion" :nombreDonaciones="nombreDonaciones" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaDonacion from "./tarjetas/TarjetaDonacion.vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import formDonacion from "./formularios/formDonacion.vue";

export default defineComponent({
  name: "PaginaDonaciones",
  components: {
    TarjetaDonacion,
    formDonacion,
  },
  setup() {
    const donaciones = ref([]);
    const rol = useStore().rol;
    const abrirForm = ref(false);

    const nombreDonaciones = ref([]);

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const loadDonaciones = async () => {
      try {
        const response = await api.get("/donacion/getDonaciones");
        if (response !== false) {
          donaciones.value = response.data;
          nombreDonaciones.value = response.data.map((donacion) => donacion.NOMBRE);
        }
      } catch (error) {
        console.error(error);
      }
    };

    const registrarDonacion = async (donacion) => {
      try {
        await api.post("/donacion/addDonacion", {
          campania: donacion,
          quienSoy: quienSoy,
        });
        abrirForm.value = false;
        loadDonaciones();
      } catch (error) {
        console.error(error);
      }
    };

    async function eliminarDonacion(data) {
      try {
        await api.post("/donacion/deleteDonacion", {
          id: data.id,
          nombre: data.nombre,
          quienSoy: quienSoy,
        });
        loadDonaciones();
      } catch {
        console.error("NO SE PUDO ELIMINAR CAMPAÑA");
      }
    }

    return {
      eliminarDonacion,
      donaciones,
      rol,
      loadDonaciones,
      registrarDonacion,
      abrirForm,
      nombreDonaciones,
    };
  },
  mounted() {
    this.loadDonaciones();
  },
});
</script>
