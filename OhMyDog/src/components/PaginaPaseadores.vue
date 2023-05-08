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
                v-for="(pas, indice) of paseadorDatos"
                :key="indice"
                :rol="rol"
                :servicio="servicioActual"
                :nombre="pas.nombre"
                :comentario="pas.comentario"
                :contacto="pas.contacto"
                :dias="pas.dias"
                :horario="pas.horario"
                :zona="pas.zona"
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
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaPaseador from "./tarjetas/TarjetaPaseador.vue";

export default defineComponent({
  name: "PaginaAdopciones",
  components: {
    TarjetaPaseador,
  },
  props: {
    rol: String,
  },
  setup() {
    return {
      tab: ref("paseadores"),
      servicioActual: "paseadores",

      paseadorDatos: [
        {
          nombre: "Juan Peréz",
          zona: "La Plata",
          dias: "Lunes a viernes",
          horario: "9:00 a 13:00",
          contacto: "julisaenz99@gmail.com",
          comentario: "Necesitan darme bolsita para los residuos del perro"
        },
        {
          nombre: "Juan Peréz",
          zona: "La Plata",
          dias: "Lunes a viernes",
          horario: "9:00 a 13:00",
          contacto: "julisaenz99@gmail.com",
          comentario: "Necesitan darme bolsita para los residuos del perro"
        },
        
      ],
    };
  },
});
</script>
