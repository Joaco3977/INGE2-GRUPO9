<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary">QUIENES SOMOS</div>
    <div class="text-center text-h6 text-primary">
      Hola! Soy el componente "Página Quienes Somos" EDITAME
    </div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh"
      class="bg-white"
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <div>holitas soy un div</div>
      <q-btn @click="aumentarRol()"> aumentar </q-btn>
      <q-btn @click="disminuirRol()"> disminuir </q-btn>
      <div>
        Este estaría visible cuando inició sesión, y los vets tmb tendrían uno
        :)
      </div>

      <div>
        ----------------- <br/>
        -1: Administrador <br/>
        0: Visitante <br/>
        1: Cliente <br/>
        2: Veterinario  <br/>
        ---------------- <br/>
        El rol actual es {{store.rol}}
      </div>

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<!-- ROLES
-1: Administrador
 0: Visitante
 1: Cliente
 2: Veterinario
--> 

<script>
import { defineComponent, reactive, ref } from "vue";
import { useStore } from "../pinia/store.js";

export default defineComponent({
  name: "PaginaQuienesSomos",
  components: {},
  setup() {
    const data = reactive({
      store: useStore(),
    });
    return data;
  },
  methods: {
    aumentarRol() {
      if ( this.store.rol < 4 ){ 
        this.store.setRol(this.store.rol + 1);
      }
    },
    disminuirRol() {
      // Hasta -1 
      if ( this.store.rol > -1 ){ 
        this.store.setRol(this.store.rol - 1);
      }
    },
  },
});
</script>
