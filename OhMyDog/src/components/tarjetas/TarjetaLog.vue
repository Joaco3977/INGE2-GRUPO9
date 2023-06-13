<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: 70vw; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"
    >
      <q-card-section class="column">
        <div class="column">
          <div class="textoFecha q-py-sm">
            Fecha: {{ formattedDate }}
          </div>
          <div class="row">
            <div class="textoDescripcion q-pr-sm q-pb-xs">
              Descripcion: {{ descripcion }}
            </div>
          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "TarjetaLog",
  components: {},
  props: {
    id: String,
    fecha: String,
    descripcion: String
  },
  setup() {
    return {}
  },
  methods: {
  },
  computed: {
    formattedDate() {
      const date = new Date(this.fecha);
      const options = { year: "numeric", month: "numeric", day: "numeric" };
      return date.toLocaleDateString(undefined, options);
    }
  },
});
</script>
