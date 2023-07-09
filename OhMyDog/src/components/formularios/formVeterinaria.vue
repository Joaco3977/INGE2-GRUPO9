<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar veterinaria
        </div>
      </q-card-section>
      <q-card-section class="q-pt-md">
        <q-form class="q-pa-md" @submit.prevent="submitForm">
          <q-input
            ref="inputRef"
            class="q-px-xl"
            label="Nombre"
            v-model="veterinaria.nombre"
          />
          <q-input
            class="q-px-xl"
            v-model="veterinaria.direccion"
            label="Direccion"
            type="text"
          />
          <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              label="Registrar veterinario"
              :disabled="!camposValidos"
              type="submit"
              color="accent"
              v-close-popup
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";
import { normalizeString } from "src/functions/misc";

export default {
  name: "formVeterinaria",
  emits: ["registrarVetTurno"],
  components: {},
  props: {
    nombresVeterinarias: {
      type: Array,
      required: true,
    },
  },
  setup(_, { emit }) {

    const veterinaria = ref({
      nombre: "",
      direccion: "",
    });

    const submitForm = () => {
      emit("registrarVetTurno", veterinaria.value);
    };

    return {
      veterinaria,
      submitForm,
    };
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push("Ingrese un nombre válido");
      }
      if (this.nombreExiste) {
        sError.push("Ya existe una veterinaria registrada con ese nombre");
      }
      if (!this.direccionValida) {
        sError.push("Ingrese una direccion válida");
      }
      return sError;
    },
    nombreExiste() {
      return (
        this.nombresVeterinarias.includes(this.veterinaria.nombre)
      );
    },
    nombreValido() {
      return (
        this.veterinaria.nombre.length > 0
      );
    },
    direccionValida() {
      return (
        this.veterinaria.direccion.length > 0
      );
    },
    camposValidos() {
      return (
        this.nombreValido &&
        !this.nombreExiste &&
        this.direccionValida
      );
    },
  },
};
</script>
