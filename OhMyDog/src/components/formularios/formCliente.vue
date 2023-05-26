<template>
  <div class="full-width row items-center bg-white">
    <div class="q-pa-md" style="width: 50rem">
      <div class="textoTituloTarjeta text-accent q-pt-md">
        Agregar Cliente
      </div>
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
          mask="(###) ### - ####"
        />
        <q-input
          class="q-px-xl"
          v-model="cliente.direccion"
          label="Direccion"
          type="text"
        />
        <q-btn
          push
          class="q-mt-lg q-mx-xl"
          color="accent"
          type="submit"
          label="Registrar Cliente"
        />
      </q-form>
    </div>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";

export default {
  name: "FormCliente",
  emits: ["registrarCliente"],
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
};
</script>
