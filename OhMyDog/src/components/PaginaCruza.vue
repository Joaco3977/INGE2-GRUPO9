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

    <q-card stretch flat class="bg-white full-width full-height column no-wrap">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md full-width"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <q-tab
          @click="loadPerrosCruza"
          name="perrosTodos"
          label="Todos los perros"
        />
        <q-tab
          @click="loadMisPerrosEnCruza"
          name="perrosRecomendados"
          label="Recomendaciones"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated class="full-width">
        <q-tab-panel name="perrosTodos">
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
              v-for="perro in perrosCruza"
              :key="perro.ID"
              :id="perro.ID"
              :rol="rol"
              :foto="perro.FOTO"
              :nombre="perro.NOMBRE"
              :nacimiento="perro.NACIMIENTO"
              :peso="perro.PESO"
              :tamanio="perro.TAMANIO"
              :sexo="perro.SEXO"
              :raza="perro.RAZA"
              :color="perro.COLOR"
              :dnicliente="perro.DNICLIENTE"
              linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡Todavía no tenemos otros perros en cruza!
          </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="perrosRecomendados" class="column">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="opcionMisPerrosEnCruza.length > 0"
            class="full-width row wrap justify-center"
          >
            <q-select
              v-if="opcionMisPerrosEnCruza.length > 0"
              v-model="miPerroElegidoCruza"
              :options="opcionMisPerrosEnCruza"
              class="full-width row wrap justify-center"
              label="Elige un perro para mostrar recomendaciones!"
            />
            <div
              v-if="perrosRecomendados.length > 0"
              class="full-width row wrap justify-center"
            >
              <TarjetaCruza
                class="q-px-sm col-stretch"
                v-for="perro in perrosRecomendados"
                :key="perro.ID"
                :id="perro.ID"
                :rol="rol"
                :foto="perro.FOTO"
                :nombre="perro.NOMBRE"
                :nacimiento="perro.NACIMIENTO"
                :peso="perro.PESO"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :raza="perro.RAZA"
                :color="perro.COLOR"
                :dnicliente="perro.DNICLIENTE"
                linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
              />
            </div>
            <div
            class="row textoNoItems justify-center full-height content-center q-pa-xl"
            v-else
            >
              ¡Todavía no tenemos ningun perro en cruza para tu perro!
            </div>
          </div>
          <div
            class="row textoNoItems justify-center full-height content-center q-pa-xl"
            v-else
            >
              ¡No tenes ningun perro en cruza!
          </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

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
import { defineComponent, watch, ref} from "vue";
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
    const perrosRecomendados = ref([])

    const tab = ref("perrosTodos");

    const rol = useStore().rol;
    const agregarPerroCruza = ref(false);

    const perroElegido = ref({ label: "", value: '' })

    const nombrePerrosCruza = ref([]);

    const opcionPerros = ref([])

    const opcionMisPerrosEnCruza = ref ([])

    const miPerroElegidoCruza = ref({ label: "", value: '' })

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const loadMisPerrosEnCruza = async () => {
      await api.post('/cruza/loadMisPerrosEnCruza', {
        dni: useStore().dni,
      })
      .then((respuesta) => {
        opcionMisPerrosEnCruza.value = []
        respuesta.data.forEach(perro => {
          opcionMisPerrosEnCruza.value.push({ label: perro.NOMBRE, value: perro })
        });
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const loadMisDisponiblesCruzar = async () => {
      try {
        await api.post("/cruza/loadMisDisponiblesCruzar", {
          dni: useStore().dni,
        })
        .then((respuesta) => {
          opcionPerros.value = []
          respuesta.data.forEach(perro => {
            opcionPerros.value.push({ label: perro.NOMBRE, value: perro })
          });
        })
      } catch (error) {
        console.log(error)
      }
    }

    const loadPerrosRecomendados = async (perro) => {
      await api.post('/cruza/getPerrosRecomendados', {
        dni: useStore().dni,
        raza: perro.RAZA,
        sexo: perro.SEXO,
      })
      .then((respuesta) => {
        perrosRecomendados.value = respuesta.data
      })
      .catch((error) => {
        console.log(error)
      })
    }

    watch(miPerroElegidoCruza, (nuevoValor, valorAnterior) => {
      loadPerrosRecomendados(nuevoValor.value)
    });

    const loadPerrosCruza = async () => {
      console.log('tocaste en loadPerrosCruza')
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
          loadMisPerrosEnCruza()
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
      perrosRecomendados,
      rol,
      loadPerrosCruza,
      registrarPerroCruza,
      agregarPerroCruza,
      nombrePerrosCruza,
      opcionPerros,
      perroElegido,
      tab,
      opcionMisPerrosEnCruza,
      miPerroElegidoCruza,
      loadPerrosRecomendados,
      loadMisDisponiblesCruzar,
      loadMisPerrosEnCruza
    };
  },
  mounted() {
    checkToken()
    this.loadPerrosCruza()
    this.loadMisDisponiblesCruzar()
  },
  computed: {
    camposValidos () {
      return this.perroElegido.label !== ''
    }
  }
});
</script>
