<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar campaña
        </div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <div class="text-h6 q-pb-xs text-center text-primary">
          Información básica
        </div>
        <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
          <q-input class="q-px-lg" filled v-model="nombre" label="Nombre" />

          <q-input
            class="q-px-lg"
            filled
            v-model="descripcion"
            label="Descripción"
          />

          <q-input class="q-px-lg" filled v-model="link" label="Link" />

          <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>

          <div class="row justify-end">
            <q-btn
              label="Registrar campaña"
              :disabled="!camposValidos"
              type="submit"
              color="accent"
            />
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

export default defineComponent({
  name: "formDonacion",
  props: {
    nombreDonaciones: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const nombre = ref("");
    const descripcion = ref("");
    const link = ref("");

    const getDatosDonacion = () => {
      const donacion = {
        NOMBRE: nombre.value,
        DESCRIPCION: descripcion.value,
        LINK: link.value,
      };
      return donacion;
    };

    return {
      nombre,
      descripcion,
      link,
      getDatosDonacion,

      onReset() {
        nombre.value = null;
        descripcion.value = null;
        link.value = null;
      },
    };
  },
  methods: {
    async onSubmit() {
      try {
        const donacion = this.getDatosDonacion();
        this.$emit("registrarDonacion", donacion);
      } catch (error) {
        console.error(error);
      }
    },
    urlValida(string){
      const urlPattern = /^(https?:\/\/)?([\w.-]+)\.([a-z]{2,})(\/.*)?$/i;
      return urlPattern.test(string);
    }
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push("Ingrese un nombre de la campaña");
      }
      if (this.nombreExiste) {
        sError.push("Ese nombre ya esta registrado");
      }
      if (!this.descripcionValida) {
        sError.push("Ingrese una descripción de la campaña");
      }
      if (!this.linkValido) {
        sError.push("El link debe ser válido");
      }
      return sError;
    },
    nombreValido() {
      return this.nombre.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.nombre);
    },
    descripcionValida() {
      return this.descripcion.length > 0;
    },
    linkValido() {
      return this.link.length > 0 && this.urlValida(this.link);
    },
    nombreExiste() {
      return this.nombreDonaciones.includes(this.nombre);
    },
    camposValidos() {
      return this.nombreValido && !this.nombreExiste && this.linkValido && this.descripcionValida;
    },
  },
});
</script>
