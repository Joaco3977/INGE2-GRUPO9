<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        ¿Quiénes somos?
      </div>
    </div>



      <div class="text-primary text-center text-bold q-pa-xl q-mt-xl">
        <p class="q-px-xl q-pb-md"> ¡Bienvenidos a OhMyDog, la veterinaria dedicada exclusivamente al cuidado de perros en La Plata! </p>
        <p class="q-px-xl q-pb-md">En OhMyDog, entendemos el vínculo especial que tienes con tu perro. Nuestro objetivo es brindarle la mejor atención veterinaria para mantenerlo saludable y feliz durante toda su vida.</p>
        <p class="q-px-xl q-pb-md">Con un equipo de profesionales apasionados y expertos en el cuidado de perros, ofrecemos servicios médicos de calidad, desde exámenes de rutina y vacunas hasta tratamientos especializados. Nuestra clínica está diseñada para que tu perro se sienta cómodo y seguro durante sus visitas.</p>
        <p class="q-px-xl q-pb-md">¡Confía en OhMyDog para el cuidado de tu fiel compañero! Estamos aquí para apoyarte en todas las necesidades veterinarias de tu perro en La Plata".</p>
      </div>

  </div>
</template>

<script>
import { defineComponent, reactive } from "vue";

export default defineComponent({
  name: "PaginaQuienesSomos",
  components: {},
  setup() {
    return {}
  },
});
</script>
