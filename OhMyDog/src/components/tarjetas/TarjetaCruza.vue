<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 50vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 80vw"
    >
      <q-card-section horizontal>
        <q-img
          class="col-3 q-pb-none"
          fit="cover"
          style="max-height: 50vh;"
          :src="rutaFoto"
        />

        <q-card-section class="column col-9 justify-between">
          <div class="">
            <div class="text-h6 text-uppercase text-bold q-pr-sm q-pb-xs">
              {{ nombre }}
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Raza:</div>
              <div>{{ raza }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Tamaño:</div>
              <div>{{ tamanio }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Peso:</div>
              <div>{{ peso }} kg</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Edad:</div>
              <div>{{ formattedDate }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
              <div>{{ sexo }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Color:</div>
              <div>{{ color }}</div>
            </div>
            <q-separator class="q-mt-xs" dark />
          </div>
          <q-card-actions class="justify-end items-center">
            <q-btn @click="contactarDuenio(id)" flat class="textoBoton"> Contactar dueño </q-btn>
          </q-card-actions>
        </q-card-section>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { api } from "src/boot/axios";
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "TarjetaCruza",
  props: {
    id: Number,
    rol: String,
    nombre: String,
    nacimiento: Date,
    tamanio: String,
    sexo: String,
    raza: String,
    peso: String,
    color: String,
    dnicliente: String,
    linkImg: String,
    foto: Number,
  },
  setup(props) {

    const rutaFoto = ref(``)

    const getFoto = async () => {
      if (props.foto === 1) {
        await api.post('/perro/getFoto', {
        id: props.id
      },
      {
        responseType: 'blob'
      })
      .then((resultado) => {
        const imageUrl = URL.createObjectURL(resultado.data);
        rutaFoto.value = imageUrl;
      })
      } else {
        rutaFoto.value = `../../../public/silueta.png`;
      }
    }

    const contactarDuenio = async () => {
      await api.post('/cruza/getNumeroDuenio', {
        dni: props.dnicliente
      })
      .then((respuesta) => {
        console.log(respuesta.data) //no se pq no lo agarra
        let cont =
          "https://api.whatsapp.com/send?phone=" +
          respuesta.data.TELEFONO +
          `&text=Contacto%20desde%20OhMyDog%20por%20perro%20de%20cruza%20${props.nombre}`;
          window.open(cont, '_blank');
      })
      .catch((error) => {
        console.log(error)
      })
    }

    return {
      mostrarPopupEditar: ref(false),
      contactarDuenio,
      getFoto,
      rutaFoto,
    };
  },
  methods: {
    eliminarPerro(nombre) {
      this.$emit("eliminarPerro", nombre);
    },
  },
  computed: {
    formattedDate() {
      const currentDate = new Date();
      const date = new Date(this.nacimiento);
      const diff = Math.abs(currentDate - date);

      const millisecondsPerDay = 24 * 60 * 60 * 1000;
      const days = Math.floor(diff / millisecondsPerDay);

      const years = Math.floor(days / 365);
      const months = Math.floor((days % 365) / 30);
      const remainingDays = days - years * 365 - months * 30;

      let formattedDate = "";

      if (years > 0) {
        formattedDate += years === 1 ? "1 año" : `${years} años`;
      }
      if (months > 0) {
        formattedDate += `${years > 0 ? ", " : ""}${
          months === 1 ? "1 mes" : `${months} meses`
        }`;
      }
      if (remainingDays > 0) {
        formattedDate += `${years > 0 || months > 0 ? ", " : ""}${
          remainingDays === 1 ? "1 día" : `${remainingDays} días`
        }`;
      }

      return formattedDate;
    },
  },
  mounted() {
    this.getFoto()
  }
});
</script>
