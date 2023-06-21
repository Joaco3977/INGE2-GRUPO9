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
              <div class=" text-primary q-pl-md q-pb-md"> {{ formattedDate }} </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Veterinario:</div>
              <div class="text-primary q-pl-md q-pb-md">DNI:{{ veterinario.DNI }} - Nombre:{{ veterinario.NOMBREAPELLIDO }} </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Servicio:</div>
              <div class="text-primary q-pl-md q-pb-md"> {{ formattedService }} </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs"> Comentario:</div>
              <div class="text-primary q-pl-md q-pb-md"> {{ comentario }} </div>
            </div>

          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { api } from "src/boot/axios";
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "TarjetaDonacion",
  components: {},
  props: {
    fecha: String,
    servicio: String,
    comentario: String,
    nombreVacuna: String,
    dniVet: String,
  },
  setup(props) {
    const veterinario = ref({})

    const getDatosVeterinario = async () => {
      await api.post('/veterinario/getVeterinario', {
        dni: parseInt(props.dniVet)
      })
      .then((response) => {
        veterinario.value = response.data;
      })
      .catch((error) => {
        console.log(error)
      })
    }

    return {
      getDatosVeterinario,
      veterinario,
    }
  },
  methods: {
  },
  mounted() {
    this.getDatosVeterinario();
  },
  computed: {
    formattedService() {
      let formattedService = this.servicio
      if (this.nombreVacuna !== null) {
        formattedService += ` - ${this.nombreVacuna}`
      }
      return formattedService;
    },
    formattedDate() {
      const date = new Date(this.fecha);
      let hora = date.getHours()
      if (hora < 10) {
        hora = `0${hora}`
      }
      let minuto = date.getMinutes()
      if (minuto < 10) {
        minuto = `0${minuto}`
      }
      let formattedDate = `${date.toLocaleDateString()} - ${hora}:${minuto}`
      return formattedDate;
    }
  },
});
</script>
