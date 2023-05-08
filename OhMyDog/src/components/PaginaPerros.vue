<template>
<!-- Todo el contenido tiene que estar adentro de un div -->
<!-- Pueden usar componentes dentro de este componente -->
<div class="bg-white" style="width: full; max-height: 90vh">

    <div class="text-center text-h4 text-primary "> MIS PERROS </div>
    <div class="text-center text-h6 text-primary "> Hola! Soy el componente "Página Perros" EDITAME </div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh;"
      class="bg-white"
    >

    <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

    <div> holitas soy un div </div>

    <div>
      la idea es que este sea solo visible para los clientes ¡woof! rawr xd  :3
    </div>

    <!-- Hasta acá :)  -->
    </q-scroll-area>
</div>

</template>

<script>
import { defineComponent, ref } from 'vue'
import { checkToken } from "../functions/check.js";

export default defineComponent({
  name: 'PaginaPerros',
  components: {

  },
  mounted() {
    checkToken()
  }
})
</script>
