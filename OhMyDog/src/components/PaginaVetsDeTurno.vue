<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        VETERINARIAS DE TURNO
      </div>
      <q-btn
        v-if="rol === 2 && tab === 'listadoVets'"
        @click="agregarVetDeTurno = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Agregar veterinaria al listado</div>
      </q-btn>
      <q-btn
        v-if="rol === 2 && tab === 'vetsTurno'"
        @click="registrarVetDeTurno = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Registrar nueva veterinaria</div>
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
          @click="loadListadoVetsTurno"
          name="listadoVets"
          label="Listado de veterinarias de turno"
        />
        <q-tab
          v-if="rol === 2"
          @click="loadVetsRegistradas"
          name="vetsTurno"
          label="Veterinarias registradas"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated class="full-width">
        <q-tab-panel name="listadoVets">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="listadoVetsTurno.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaVeterinaria
              class="q-px-sm col-stretch"
              v-for="vet in listadoVetsTurno"
              @eliminarVetTurno="eliminarVetTurno"
              :key="vet.ID"
              :tab="tab"
              :id="vet.ID"
              :nombre="vet.NOMBRE"
              :direccion="vet.DIRECCION"
              :fecha="vet.FECHA"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡No hay ninguna veterinaria de turno!
          </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel name="vetsTurno" class="column">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="vetsTurnoRegistradas.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaVeterinaria
              class="q-px-sm col-stretch"
              v-for="vet in vetsTurnoRegistradas"
              @eliminarVetTurno="eliminarVetTurno"
              @loadVetsRegistradas="loadVetsRegistradas"
              :key="vet.ID"
              :tab="tab"
              :id="vet.ID"
              :nombre="vet.NOMBRE"
              :direccion="vet.DIRECCION"
              :nombresVeterinarias="nombresVeterinarias"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡Todavía se registro ninguna veterinaria de turno!
          </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="agregarVetDeTurno">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Agregar veterinaria al listado</div>
        </q-card-section>

        <q-card-section class="q-pt-none" v-if="vetsTurnoRegistradas.length === 0">
          No hay ninguna veterinaria registrada para agregar
        </q-card-section>

        <q-date
          v-if="vetsTurnoRegistradas.length > 0"
          class="q-mb-lg"
          v-model="fechaTurno"
          minimal
          :options="opcionesFecha"
        />

        <q-select
            v-if="vetsTurnoRegistradas.length > 0"
            v-model="vetElegida"
            :options="opcionVetsTurno"
            class="q-px-xl"
            label="Veterinaria"
        />

        <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            @click="agregarVetListado(vetElegida.value.ID, fechaTurno)"
            :disabled="!camposValidos"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Volver" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="registrarVetDeTurno">
      <FormVeterinaria
        @registrarVetTurno="registrarVetTurno"
        :nombresVeterinarias="nombresVeterinarias"
      />
    </q-dialog>
  </div>
</template>
<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import TarjetaVeterinaria from "./tarjetas/TarjetaVeterinaria.vue";
import FormVeterinaria from "./formularios/formVeterinaria.vue"

export default defineComponent({
  name: "PaginaVetsDeTurno",
  components: {
    TarjetaVeterinaria,
    FormVeterinaria
  },
  setup() {
    const listadoVetsTurno = ref([]);
    const vetsTurnoRegistradas = ref([])

    const tab = ref("listadoVets");

    const rol = useStore().rol;
    const agregarVetDeTurno = ref(false);
    const registrarVetDeTurno = ref(false);

    const vetElegida = ref({ label: "", value: '' })
    const veterinariaRegistrar = ref({
      nombre: '',
      direccion: '',
    })

    const fechaTurno = ref("")

    const nombresVeterinarias = ref([])

    const opcionVetsTurno = ref([])

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const loadVetsDisponibles = async () => {
      await api.get('/vetsTurno/getVetsRegistradas')
      .then((resultado) => {
        opcionVetsTurno.value = []
        resultado.data.forEach(vet => {
          opcionVetsTurno.value.push({ label: vet.NOMBRE, value: vet })
        });
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const loadVetsRegistradas = async () => {
      await api.get('/vetsTurno/getVetsRegistradas')
      .then((resultado) => {
        vetsTurnoRegistradas.value = resultado.data
        nombresVeterinarias.value = resultado.data.map((vet) => vet.NOMBRE);
      })
      .catch((error) => {
        console.log(error)
      })
    };

    const loadListadoVetsTurno = async () => {
      await api.get('/vetsTurno/getListadoVetsTurno')
      .then((resultado) => {
        listadoVetsTurno.value = resultado.data.sort((a, b) => new Date(a.FECHA) - new Date(b.FECHA));
      })
      .catch((error) => {
        console.log(error)
      })
    };

    const registrarVetTurno = async (veterinaria) => {
      await api.post('/vetsTurno/registrarVeterinariaRegistrada', {
        veterinaria: veterinaria,
      })
      .then(() => {
        loadVetsRegistradas();
        loadVetsDisponibles();
      })
      .catch((error) => {
        console.log(error)
      })
    };

    const agregarVetListado = async(id, fecha) => {
      const vetSeleccionada = vetsTurnoRegistradas.value.find(vet => vet.ID === id)
      const nuevaVet = {
        nombre: vetSeleccionada.NOMBRE,
        direccion: vetSeleccionada.DIRECCION,
        fecha: fecha,
      }
      await api.post('/vetsTurno/agregarVeterinariaListado', {
        veterinaria: nuevaVet
      })
      .then(() => {
        loadListadoVetsTurno()
        fechaTurno.value = ''
        vetElegida.value = { label: "", value: '' }
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const eliminarVetTurno = async (data) => {
      if (data.tab === 'listadoVets') {
        await api.post('/vetsTurno/eliminarVeterinariaListado', {
          id: data.id
        })
        .then(() => {
          loadListadoVetsTurno()
        })
        .catch((error) => {
          console.log(error)
        })
      } else {
        await api.post('/vetsTurno/eliminarVeterinariaRegistrada', {
          id: data.id
        })
        .then(() => {
          loadVetsRegistradas()
          loadVetsDisponibles()
        })
        .catch((error) => {
          console.log(error)
        })
      }
    }

    const opcionesFecha = (date) => {
      const hoy = new Date().toLocaleDateString("zh-Hans-CN", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      return date >= hoy;
    };

    return {
      tab,
      rol,
      listadoVetsTurno,
      vetsTurnoRegistradas,
      agregarVetDeTurno,
      registrarVetDeTurno,
      vetElegida,
      nombresVeterinarias,
      opcionVetsTurno,
      veterinariaRegistrar,
      fechaTurno,
      eliminarVetTurno,
      registrarVetTurno,
      loadVetsDisponibles,
      loadVetsRegistradas,
      loadListadoVetsTurno,
      opcionesFecha,
      agregarVetListado,
    };
  },
  mounted() {
    this.loadVetsDisponibles()
    this.loadVetsRegistradas()
    this.loadListadoVetsTurno()
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.veterinariaElegida && this.vetsTurnoRegistradas.length > 0) {
        sError.push("Seleccione una veterinaria");
      }
      if (!this.fechaElegida && this.vetsTurnoRegistradas.length > 0) {
        sError.push("Seleccione una fecha");
      }
      return sError;
    },
    veterinariaElegida() {
      return this.vetElegida.label !== ''
    },
    fechaElegida() {
      return this.fechaTurno !== ''
    },
    camposValidos () {
      return this.fechaElegida && this.veterinariaElegida
    }
  }
});
</script>
