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
                :servicio='servicioActual'
                :nombre='perro.nombre'
                :edad='perro.edad'
                :tamanio='perro.tamanio'
                :raza='perro.raza'
                :comentario='perro.comentario'
                :contacto='perro.contacto'
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="perrosPropios" class="column">
          <q-btn color="accent" class="q-ma-md q-mr-xl self-end" style="width: 20em">
                <div class="textoBoton">¡Poné un perro en adopción! </div>
          </q-btn>
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
                :raza='perro.raza'
                :comentario='perro.comentario'
                :contacto='perro.contacto'
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaAdopcion from "./tarjetas/TarjetaAdopcion.vue";
import { useStore } from '../pinia/store.js'

export default defineComponent({
  name: "PaginaAdopciones",
  components: {
    TarjetaAdopcion,
  },
  props: {
    rol: String,
  },

  setup() {
    //
    /*
    const store = useStore();

    const loadPerros = async () => {
      try {
        const response = await api.get("/perroAdopcion/getPerrosAdopcion")
          perrosDatos.value = response.data;
      }
      catch (error) {
        console.error(error);
      }
    };

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
    return {
      tab: ref("perrosOtros"),
      servicioActual: "adopciones",
      misAdopciones: "misPerros",

      perrosDatos: [
        {
          nombre: "Pep",
          raza: "Dálmata",
          edad: "9 meses",
          tamanio: "Pequeño",
          comentario: "",
          contacto: "julisaenz99@gmail.com",
        },
        {
          nombre: "Pulgas",
          raza: "Mestizo",
          edad: "2 meses",
          tamanio: "Grande",
          comentario: "Es enorme, es el perro más grande del mundo",
          contacto: "2215621322",
        },
        {
          nombre: "Machas",
          raza: "Mestizo",
          edad: "3 meses",
          tamanio: "Pequeño",
          comentario: "Es re buenito",
          contacto: "julisaenz99@gmail.com",
        },
        {
          nombre: "Machas",
          raza: "Mestizo",
          edad: "3 meses",
          tamanio: "Pequeño",
          comentario: "Es re buenito",
          contacto: "julisaenz99@gmail.com",
        },
        {
          nombre: "Machas",
          raza: "Mestizo",
          edad: "3 meses",
          tamanio: "Pequeño",
          comentario: "Es re malo! Llevenselo! No lo quiero!",
          contacto: "julisaenz99@gmail.com",
        },
      ],
    };
  },
  mounted : {
   // loadPerros
  }
});
</script>
