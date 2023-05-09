<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->

  <div class="bg-white full-height full-width" style="height: 97vh">
    <div class="titulo text-center text-h4 text-primary q-pt-md">ADOPCIONES</div>
    <q-card stretch flat class="bg-white full-width full-height">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
      <!-- EN ESTA ETIQUETA VA @click="loadPerros" y a su vez tambien va en el mounted para que cargue de entrada todos los perros disponible ( faltaria agregar un label que informe cuando no hya perros (vectordedatos vuelve vacio de db))-->
        <q-tab name="perrosOtros" label="¡Adoptá un perro!" />
        <q-tab
          v-if="rol > 0"
          name="perrosPropios"
          label="Mis perros en adopción"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated>
        <q-tab-panel name="perrosOtros">
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 75vh; width:100%"
            class="bg-white full-width"
          >

          <div class="full-width row items-justify">
              <TarjetaAdopcion
                v-for="(perro, indice) of perrosDatos" :key="indice"
                :rol='rol'
                :servicio='misAdopciones'
                :nombre='perro.nombre'
                :edad='perro.edad'
                :tamanio='perro.tamanio'
                :sexo="perro.sexo"
                :telefono="perro.telefono"
                :mail="perro.mail"
                :comentario='perro.comentario'
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="perrosPropios" class="column">
          <q-btn @click="mostrarPopupM" color="accent" class="q-ma-md q-mr-xl self-end" style="width: 20em">
                <div class="textoBoton">¡Poné un perro en adopción! </div>
          </q-btn>
          <q-dialog v-model="mostrarPopup">
            <div class="paraform" style="width: 50vw; height: 80vh">
              <q-form class="q-pa-xl" @submit.prevent="registrarPerro" >
                <q-input v-model="perroNOMBRE" clearable class="q-px-xl" label="Nombre" type="text" />
                <q-input v-model="perroTAMANIO" clearable class="q-px-xl" label="Tamaño" type="text" />
                <q-input v-model="perroEDAD" clearable class="q-px-xl" label="Edad Aproximada" type="text" />
                <q-input v-model="perroSEXO" clearable class="q-px-xl" label="Sexo" type="text" />
                <q-input v-model="perroTELEFONO" clearable class="q-px-xl" label="Telefono" type="text" />
                <q-input v-model="perroMAIL" clearable class="q-px-xl" label="Mail" type="email" />
                <q-input v-model="perroCOMENTARIO" clearable class="q-px-xl" label="Comentarios" type="text" />
                <q-btn push class="q-my-md q-mx-xl" color="accent" type="submit" label="Registrar Perro" />
              </q-form>
            </div>
          </q-dialog>
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 60vh; width:100%"
            class="bg-white full-width"
          >
          <div class="full-width row items-justify">
              <TarjetaAdopcion
                v-for="(perro, indice) of perrosDatos" :key="indice"
                :rol='rol'
                :servicio='misAdopciones'
                :nombre='perro.nombre'
                :edad='perro.edad'
                :tamanio='perro.tamanio'
                :sexo="perro.sexo"
                :telefono="perro.telefono"
                :mail="perro.mail"
                :comentario='perro.comentario'
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>
  </div>
</template>

<style>
  .paraform {
    background-color: #fff;
  }
</style>

<script>
import { defineComponent } from "vue";
import { ref , reactive} from "vue";
import { QDialog } from 'quasar'
import TarjetaAdopcion from "./tarjetas/TarjetaAdopcion.vue";
import { useStore } from '../pinia/store.js'
import { api } from '../boot/axios.js';

export default defineComponent({
  name: "PaginaAdopciones",
  components: {
    TarjetaAdopcion,
    QDialog,
  },

  setup() {
    const perrosDatos = reactive([]);
    const  perroSEXO = ref('')
    const  perroTAMANIO =ref('')
    const  perroEDAD =ref('')
    const  perroTELEFONO =ref('')
    const  perroNOMBRE=ref('')
    const  perroMAIL=ref('')
    const  perroCOMENTARIO =ref('')
    const  perroDNICLIENTE = useStore.dni;
    const  mostrarPopup = ref('false');
    const  rol = useStore().rol

    const registrarPerro =async  () => {
      try {
        const response = await api.post("/perroAdopcion/addPerroAdopcion", {
          perro: {
            sexo:perroSEXO.value,
            tamanio:perroTAMANIO.value,
            edad:perroEDAD.value,
            telefono:perroTELEFONO.value,
            nombre:perroNOMBRE.value,
            mail:perroMAIL.value,
            comentario:perroCOMENTARIO.value,
            dnicliente:perroDNICLIENTE,
          }
        })
      } catch (error) {
        console.error(error);
      }
    }

    const loadPerros = async () => {
      try {
        const response = await api.get("/perroAdopcion/getPerrosAdopcion")
          perrosDatos.value = response.data;
          console.log(perrosDatos.value)
      }
      catch (error) {
        console.error(error);
      }
    };
/*
    const loadPerrosPropios = async () => {
      try {
        const response = await api.post("/perroAdopcion/getPerrosAdopcionPropios",{ useStore.dni })
          perrosDatos.value = response.data;
      }
      catch (error) {
        console.error(error);
      }
    };

*/  
    const mostrarPopupM=()=> {
      mostrarPopup.value = !mostrarPopup.value;
    }

    return {
      tab: ref("perrosOtros"),
      store : useStore(),
      servicioActual: "adopciones",
      misAdopciones: "misPerros",
      perroSEXO,
      perroTAMANIO,
      perroEDAD,
      perroTELEFONO,
      perroNOMBRE,
      perroMAIL,
      perroCOMENTARIO,
      perroDNICLIENTE,
      registrarPerro,
      perrosDatos,
      loadPerros: ref(loadPerros),
      mostrarPopupM,
      mostrarPopup,
      rol
      }
    },
  mounted() {
    this.loadPerros()
  }
});
</script>
