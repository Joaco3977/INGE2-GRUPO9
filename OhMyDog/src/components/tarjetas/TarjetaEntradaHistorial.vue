<template>
  <div class="bg-primary" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-white text-white q-my-md"
      style="width: 60vw"
    >
      <!-- style="min-width: 20rem; max-width: 25rem" -->
      <q-card-section>
        <!-- Contenido -->
        <div class="row no-wrap">
          <div class="column col-12 justify-start q-pl-sm">
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Fecha:</div>
              <div class=" text-primary q-pl-md q-pb-md">{{ fecha }} aa </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Servicio:</div>
              <div class="text-primary q-pl-md q-pb-md">{{ servicio }} aa </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Notas:</div>
              <div class="text-primary q-pl-md q-pb-md"> {{ notas }} aa </div>
            </div>

          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "TarjetaDonacion",
  components: {},
  props: {
    fecha: String,
    servicio: String,
    descripcion: String,
  },
  setup() {
  },
  methods: {
  },
  mounted() {},
  computed: {
  },
});
</script>
