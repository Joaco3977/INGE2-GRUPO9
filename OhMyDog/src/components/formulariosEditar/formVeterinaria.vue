<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Editar veterinaria
        </div>
      </q-card-section>
      <q-card-section class="q-pt-md">
        <q-form class="q-pa-md">
          <q-input
            ref="inputRef"
            class="q-px-xl"
            label="DNI"
            v-model="veterinaria.nombre"
          />
          <q-input
            class="q-px-xl"
            v-model="veterinaria.direccion"
            label="Nombre y Apellido"
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
              label="Editar veterinario"
              :disabled="!camposValidos"
              color="accent"
              @click ="confirmar = true"
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>

    <q-dialog v-model="confirmar">
    <q-card>
      <q-card-section>
        <div class="textoTituloTarjeta text-primary">¿Editar veterinaria?</div>
      </q-card-section>

      <q-card-actions align="right">
        <q-btn flat label="Cancelar" color="primary" v-close-popup />

        <q-btn
          flat
          label="Confirmar"
          @click="submitForm"
          color="primary"
          v-close-popup
        />
      </q-card-actions>
    </q-card>
  </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";

export default {
  name: "formVeterinaria",
  components: {},
  props: {
    nombre: String,
    direccion: String,
    nombresVeterinarias: {
      type: Array,
      required: true,
    },
  },
  setup(props, { emit }) {
    const veterinaria = ref({
      nombre: props.nombre,
      direccion: props.direccion,
    });
    const nombreA = veterinaria.value.nombre;
    const direccionA = veterinaria.value.direccion;

    const submitForm = () => {
      emit("editarVeterinaria", veterinaria.value);
    };

    return {
      veterinaria,
      submitForm,
      nombreA,
      direccionA,
      confirmar: ref(false),
    };
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push("Ingrese un nombre válido");
      }
      if (this.nombreExiste) {
        sError.push("Ya existe una veterinaria con ese nombre");
      }
      if (!this.direccionValida) {
        sError.push("Ingrese una direccion valida");
      }
      return sError;
    },
    nombreExiste() {
      if(this.veterinaria.nombre == this.nombreA){
          return false
      }else{
      return (this.nombresClientes.includes(this.veterinaria.nombre));
    }},
    nombreValido() {
      return (
          this.veterinaria.nombre.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.veterinaria.nombre)
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
        this.direccionValida &&
        !this.nombreExiste
      );
    },
  },
};
</script>
