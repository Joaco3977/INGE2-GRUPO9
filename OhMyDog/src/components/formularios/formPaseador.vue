<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold" >Agregar paseador</div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <div class="text-h6 q-pb-xs text-center text-primary"> Información básica </div>
        <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
          <q-input
            class="q-px-lg"
            filled
            v-model="name"
            label="Nombre y apellido"
            hint="Nombre y apellido"
            lazy-rules
            :rules="[
              (val) => (val && val.length > 0) || 'No te olvides del nombre!',
            ]"
          />

          <q-input
            class="q-px-lg"
            filled
            type="number"
            v-model="dni"
            label="DNI"
            lazy-rules
            :rules="[
              (val) => (val !== null) || 'No te olvides del DNI!',
            ]"
          />

          <q-input
            class="q-px-lg"
            filled
            type="email"
            v-model="mail"
            label="Mail de contacto"
            lazy-rules
            :rules="[
              (val) => (val !== null && val !== '') || 'No te olvides del mail!',
            ]"
          />

          <q-input
            class="q-px-lg"
            filled
            v-model="zona"
            label="Zona"
            lazy-rules
            :rules="[
              (val) => (val && val.length > 0) || 'No te olvides de la zona!',
            ]"
          />

          <div class="column q-px-lg bg-white">
            <div class="text-h6 q-pb-xs text-center text-primary"> Días y horarios disponibles </div>
            <div
              v-for="sem of semana"
              :key="sem.nombre"
              class="separadorFormulario row no-wrap full-width justify-around items-center q-py-xs"
            >
              <div class="textoTituloPosteo" style="width: 5em">
                {{ sem.nombre }}
              </div>
              <q-checkbox v-model="dias" :val="sem.manana" label="Mañana" />
              <q-checkbox v-model="dias" :val="sem.tarde" label="Tarde" />
              <q-checkbox v-model="dias" :val="sem.noche" label="Noche" />
            </div>
          </div>

            <div class="text-h6 q-pt-md text-center text-primary"> Información adicional </div>
          <q-input
            class="q-px-lg"
            v-model="info"
            clearable
            filled
            placeholder="Información adicional"
            type="textarea"
          />

          <div class="row justify-end">
            <q-btn label="Registrar paseador" type="submit" color="accent" />
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { data } from "autoprefixer";

const semana = [
  {
    num: 0,
    nombre: "Lunes",
    manana: "0 0",
    tarde: "0 1",
    noche: "0 2",
  },
  {
    num: 1,
    nombre: "Martes",
    manana: "1 0",
    tarde: "1 1",
    noche: "1 2",
  },
  {
    num: 2,
    nombre: "Miércoles",
    manana: "2 0",
    tarde: "2 1",
    noche: "2 2",
  },
  {
    num: 3,
    nombre: "Jueves",
    manana: "3 0",
    tarde: "3 1",
    noche: "3 2",
  },
  {
    num: 4,
    nombre: "Viernes",
    manana: "4 0",
    tarde: "4 1",
    noche: "4 2",
  },
  {
    num: 5,
    nombre: "Sábado",
    manana: "5 0",
    tarde: "5 1",
    noche: "5 2",
  },
  {
    num: 6,
    nombre: "Domingo",
    manana: "6 0",
    tarde: "6 1",
    noche: "6 2",
  },
];

export default defineComponent({
  name: "formPaseador",
  setup() {
    const name = ref(null);
    const dni = ref(null);
    const mail = ref(null);
    const zona = ref(null);
    const info = ref(null);

    const dias = ref([]);

    const getDatosPaseador = () => {
      var disponibilidad = [[false, false, false],[false, false, false],[false, false, false],[false, false, false],[false, false, false],[false, false, false],[false, false, false]]
      dias.value.forEach(element => {
        let partes = element.split(' ')
        let dia = parseInt(partes[0]);
        let numero = parseInt(partes[1]);
        disponibilidad[dia][numero] = true;
      })
      const disponibilidadJSON = JSON.stringify(disponibilidad);
      const datos = {
        nombre: name.value,
        dni: dni.value,
        mail: mail.value,
        zona: zona.value,
        disponibilidadJSON: disponibilidadJSON,
        comentario: info.value,
      }
      return datos
    }

    return {
      name,
      mail,
      info,
      zona,
      dni,
      dias,
      getDatosPaseador,
      semana,

      onReset() {
        name.value = null;
        mail.value = null;
        zona.value = null;
        info.value = null;
        dias.value = null;
      },
    };
  },
  methods: {
    async onSubmit () {
      try {
        const data = this.getDatosPaseador()
        this.$emit('registrarPaseador', data);
      } catch (error){
        console.error(error)
      }
    }
  }
});
</script>
