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

      <div>
        <h5>
          SOBRE NOSOTROS
        </h5>
        <p> ¡Bienvenidos a OhMyDog, la veterinaria dedicada exclusivamente al cuidado de perros en La Plata! </p>
        <p>En OhMyDog, entendemos el vínculo especial que tienes con tu perro. Nuestro objetivo es brindarle la mejor atención veterinaria para mantenerlo saludable y feliz durante toda su vida.</p>
        <p>Con un equipo de profesionales apasionados y expertos en el cuidado de perros, ofrecemos servicios médicos de calidad, desde exámenes de rutina y vacunas hasta tratamientos especializados. Nuestra clínica está diseñada para que tu perro se sienta cómodo y seguro durante sus visitas.</p>
        <p>¡Confía en OhMyDog para el cuidado de tu fiel compañero! Estamos aquí para apoyarte en todas las necesidades veterinarias de tu perro en La Plata".</p>
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
import { checkToken } from "../functions/check.js"

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
      if ( this.store.rol < 2 ){
        this.store.setRol(this.store.rol + 1);
      }
    },
    disminuirRol() {
      // Hasta -1
      if ( this.store.rol > -1 ){
        this.store.setRol(this.store.rol - 1);
      }
    },
    validarToken() {
      checkToken();
    }
  },
});
</script>
