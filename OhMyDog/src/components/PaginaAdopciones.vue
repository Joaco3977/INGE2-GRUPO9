<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-pt-md">ADOPCIONES {{rol}}</div>


    <q-tabs
          v-model="tab"
          dense
          class="text-grey q-pt-lg"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
          <q-tab name="perrosOtros" label="¡Adoptá un perro!" />
          <q-tab v-if="rol > 0" name="perrosPropios" label="Mis perros en adopción" />
    </q-tabs>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 70vh"
      class="bg-white "
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <!-- -->
      <q-card flat>


        <q-separator />

        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="perrosOtros">
            <div class="full-width row items-center">
              <!-- Posteos de perros ACÁ DEBERÍA ENTRAR LA INFO DE PERROS DE LA BASE DE DATOS -->
              <TarjetaAdopcion
                v-for="(perro, indice) of perrosDatos" :key="indice"
                :rol='rol'
                :servicio='servicioActual'
                :nombre='perro.nombre'
                :edad='perro.edad'
                :tamanio='perro.tamanio'
                :raza='perro.raza'
                :comentario='perro.comentario'
              />
            </div>
          </q-tab-panel>

          <q-tab-panel v-if="rol > 0" name="perrosPropios" style="height: full">
            <div class="full-width column items-center">
              <q-btn color="accent" class="q-ma-md" style="width: 25em">
                <q-icon left size="3em" name="ion-heart-empty" />
                <div class="textoBoton">¡Poné un perro en adopción! </div>
              </q-btn>
            </div>
          </q-tab-panel>
        </q-tab-panels>
      </q-card>
      <!-- -->

      <!-- los veterinarios tendrían una vista, los clientes otras Y LOS VISITANTES OTRAS??

      ahora estoy pensando en texto...
      - visitante: ver
      - cliente: ver, subir, ver subidos ( nota: usar dos columnas )
      - vet: ver editar -->

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaAdopcion from "./tarjetas/TarjetaAdopcion.vue";

export default defineComponent({
  name: "PaginaAdopciones",
  components: {
    TarjetaAdopcion,
  },
  props: {
    rol: String,
  },
  setup() {
    return {
      tab: ref("perrosOtros"),
      servicioActual: "adopciones",

      perrosDatos:[
        {
          nombre: 'Pep',
          raza: 'Dálmata',
          edad: '9 meses',
          tamanio: 'Pequeño',
          comentario: '',
        },
        {
          nombre: 'Pulgas',
          raza: 'Mestizo',
          edad: '2 meses',
          tamanio: 'Grande',
          comentario: 'Es enorme, es el perro más grande del mundo'
        },
        {
          nombre: 'Machas',
          raza: 'Mestizo',
          edad: '3 meses',
          tamanio: 'Pequeño',
          comentario: 'Es re buenito'
        },
        {
          nombre: 'Machas',
          raza: 'Mestizo',
          edad: '3 meses',
          tamanio: 'Pequeño',
          comentario: 'Es re buenito'
        },
        {
          nombre: 'Machas',
          raza: 'Mestizo',
          edad: '3 meses',
          tamanio: 'Pequeño',
          comentario: 'Es re malo! Llevenselo! No lo quiero!'
        },
      ]
    };
  },
});
</script>
