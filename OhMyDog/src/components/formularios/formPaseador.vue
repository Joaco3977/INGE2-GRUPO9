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
              (val) => (val && val.length > 0) || 'Please type something',
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
              (val) => (val !== null && val !== '') || 'Please type your mail',
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

const semana = [
  {
    nombre: "Lunes",
    manana: "lunManana",
    tarde: "lunTarde",
    noche: "lunNoche",
  },
  {
    nombre: "Martes",
    manana: "marManana",
    tarde: "marTarde",
    noche: "marNoche",
  },
  {
    nombre: "Miércoles",
    manana: "mieManana",
    tarde: "mieTarde",
    noche: "mieNoche",
  },
  {
    nombre: "Jueves",
    manana: "jueManana",
    tarde: "jueTarde",
    noche: "jueNoche",
  },
  {
    nombre: "Viernes",
    manana: "vieManana",
    tarde: "vieTarde",
    noche: "vieNoche",
  },
  {
    nombre: "Sábado",
    manana: "sabManana",
    tarde: "sabTarde",
    noche: "sabNoche",
  },
  {
    nombre: "Domingo",
    manana: "domManana",
    tarde: "domTarde",
    noche: "domNoche",
  },
];

export default defineComponent({
  name: "formPaseador",
  setup() {
    const name = ref(null);
    const mail = ref(null);
    const info = ref(null);

    const dias = ref([]);

    return {
      name,
      mail,
      info,
      dias,

      semana,

      onSubmit() {
        /* Acá que pasa cuando toco "registrar" */
        /* acá podemos validar todos los campos y si no valida no se manda a la bd */
      },

      onReset() {
        name.value = null;
        mail.value = null;
        info.value = null;
        dias.value = null;
      },
    };
  },
});
</script>
