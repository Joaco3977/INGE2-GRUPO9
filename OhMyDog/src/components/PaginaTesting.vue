<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary">PAGINA PARA TESTING</div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh"
      class="bg-white"
    >

      <div>
        <h5>
          ACA DIVS
        </h5>

      </div>

    <div>
    </div>

    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent ({
  setup() {
    return {};
  }
})
</script>
