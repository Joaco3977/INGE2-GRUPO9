<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar cliente
        </div>
      </q-card-section>
      <q-card-section class="q-pt-md">
        <q-form class="q-pa-md" @submit.prevent="submitForm">
          <q-input
            ref="inputRef"
            class="q-px-xl"
            label="DNI"
            v-model="cliente.dni"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.nombreApellido"
            label="Nombre y Apellido"
            type="text"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.mail"
            label="Correo electrónico"
            type="email"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.telefono"
            label="Telefono"
            type="tel"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.direccion"
            label="Direccion"
            type="text"
          />
          <ul class="q-mx-md q-py-xs">
          <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
            {{ mnsj }}
          </li>
          </ul>
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Registrar paseador"
              :disabled="!camposValidos"
              type="submit"
              color="accent"
              v-close-popup
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
import { defineComponent, reactive, ref, watch } from "vue";

export default {
  name: "FormCliente",
  emits: ["registrarCliente"],
   props: {
    mailsClientes: {
      type: Array,
      required: true,
    },
  },
  setup(_, { emit }) {
    const cliente = ref({
      dni: "",
      nombreApellido: "",
      mail: "",
      telefono: "",
      direccion: "",
    });

    const submitForm = () => {
      emit("registrarCliente", cliente.value);
    };

    return {
      cliente,
      submitForm,
    };
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push(" El nombre no es correcto");
      }
      if (!this.dniValido) {
        sError.push("El DNI no es correcto");
      }
      if (!this.mailValido) {
        sError.push("El mail no es correcto o ya está registrado");
      }
      if (!this.telefonoValido) {
        sError.push("La telefono no es correcta");
      }
      if (!this.direccionValida) {
        sError.push("La dirección no es correcta");
      }
      return sError;
    },
    nombreValido() {
      return (
        this.cliente.nombreApellido.length > 0 &&
        /^[A-Za-z\s]+$/.test(this.cliente.nombreApellido)
      );
    },
    dniValido() {
      return this.cliente.dni.length == 8 && /^\d+$/.test(this.cliente.dni);
    },
    mailValido() {
      return (
        this.cliente.mail.length > 5 &&
        this.cliente.mail.includes("@") &&
        this.cliente.mail.includes(".") &&
        !this.mailsClientes.includes(this.cliente.mail)
      );
    },
    direccionValida() {
      return this.cliente.direccion.length > 0;
    },
    telefonoValido() {
      return (
        this.cliente.telefono.length > 6 && /^\d+$/.test(this.cliente.telefono)
      );
    },
    camposValidos() {
      console.log(this.telefonoValido)
      return (
        this.nombreValido &&
        this.dniValido &&
        this.mailValido &&
        this.telefonoValido &&
        this.direccionValida
      );
    },
  },
};
</script>
