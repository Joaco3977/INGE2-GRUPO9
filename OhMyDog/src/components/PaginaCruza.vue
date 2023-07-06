<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        CRUZA
      </div>
      <q-btn
        @click="agregarPerroCruza = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Agregar perro para cruzar</div>
      </q-btn>
    </div>

    <div>

    </div>

    <q-separator />

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 86vh"
      class="bg-white"
    >
      <div
        v-if="perrosCruza.length > 0"
        class="full-width row wrap justify-center"
      >
        <TarjetaCruza
          class="q-px-sm col-stretch"
          :nombrePerrosCruza="nombrePerrosCruza"
          v-for="perro in perrosCruza"
          :key="perro.ID"
          :rol="rol"
          :id="perro.ID"
        />
      </div>
      <div
        class="row textoNoItems justify-center full-height content-center q-pa-xl"
        v-else
      >
        ¡Todavía no tenemos ningun perro en cruza para tu perro!
      </div>
    </q-scroll-area>

    <q-dialog v-model="agregarPerroCruza">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Agregar perro de cruza</div>
        </q-card-section>

        <q-card-section class="q-pt-none" v-if="opcionPerros.length === 0">
          No quedan perros para cruzar
        </q-card-section>

        <q-select
            v-if="opcionPerros.length > 0"
            v-model="perroElegido"
            :options="opcionPerros"
            class="q-px-xl"
            label="Perro"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            @click="registrarPerroCruza(perroElegido.value.ID, fechaCelo)"
            :disabled="!camposValidos"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Volver" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import { checkToken } from "src/functions/check";
import TarjetaCruza from "./tarjetas/TarjetaCruza.vue";

export default defineComponent({
  name: "PaginaCruza",
  components: {
    TarjetaCruza,
  },
  setup() {
    const perrosCruza = ref([]);
    const rol = useStore().rol;
    const agregarPerroCruza = ref(false);

    const perroElegido = ref({ label: "", value: '' })
    const fechaCelo = ref("")

    const nombrePerrosCruza = ref([]);

    const opcionPerros = ref([])

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const loadMisDisponiblesCruzar = async () => {
      try {
        await api.post("/cruza/loadMisDisponiblesCruzar", {
          dni: useStore().dni,
        })
        .then((respuesta) => {
          respuesta.data.forEach(perro => {
            opcionPerros.value.push({ label: perro.NOMBRE, value: perro })
          });
        })
      } catch (error) {
        console.log(error)
      }
    }

    loadMisDisponiblesCruzar()

    const loadPerrosCruza = async () => {
      try {
        const response = await api.post("/cruza/getPerrosCruza", {
          dni: useStore().dni,
        });
        if (response !== false) {
          perrosCruza.value = response.data;
          nombrePerrosCruza.value = response.data.map((perro) => perro.NOMBRE);
        }
      } catch (error) {
        console.error(error);
      }
    };

    const registrarPerroCruza = async (id) => {
      await api.post('/cruza/addPerroCruza', {
            id: id,
        })
        .then(() => {
          perroElegido.value = { label: "", value: '' }
          opcionPerros.value = []
          loadMisDisponiblesCruzar()
        }).catch((error) => {
          console.log(error)
        })
    };

    async function eliminarPerroCruza(data) {
      try {
        await api.post("/cruza/deletePerroCruza", {
          id: data.id,
          nombre: data.nombre,
          quienSoy: quienSoy,
        });
        loadPerrosCruza();
      } catch {
        console.error("NO SE PUDO ELIMINAR CAMPAÑA");
      }
    }

    return {
      eliminarPerroCruza,
      perrosCruza,
      rol,
      loadPerrosCruza,
      registrarPerroCruza,
      agregarPerroCruza,
      nombrePerrosCruza,
      opcionPerros,
      perroElegido,
      fechaCelo
    };
  },
  mounted() {
    checkToken()
    this.loadPerrosCruza()
  },
  computed: {
    camposValidos () {
      return this.perroElegido.label !== ''
    }
  }
});
</script>
