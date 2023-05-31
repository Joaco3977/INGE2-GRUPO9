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
            label="Teléfono"
            type="tel"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.direccion"
            label="Dirección"
            type="text"
          />
          <ul class="q-mx-md q-py-xs">
          <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
            {{ mnsj }}
          </li>
          </ul>
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Registrar cliente"
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
import { normalizeString } from "src/functions/misc";

export default {
  name: "formCliente",
  emits: ["registrarCliente"],
  components:{
  },
   props: {
    mailsClientes: {
      type: Array,
      required: true,
    },
    dniClientes: {
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
    }
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push("Ingrese un nombre válido");
      }
      if (!this.dniValido) {
        sError.push("Ingrese un DNI válido (sin puntos)");
      }
      if ( this.dniExiste) {
        sError.push( "Un cliente con este DNI ya está registrado" )
      } 
      if (!this.mailValido) {
        sError.push("Ingrese un mail válido");
      }
      if ( this.mailExiste) {
        sError.push( "Un cliente con este mail ya está registrado" )
      } 
      if (!this.telefonoValido) {
        sError.push("Ingrese un teléfono válido");
      }
      if (!this.direccionValida) {
        sError.push("Ingrese una dirección válida");
      }
      return sError;
    },
    mailExiste(){
      return this.mailsClientes.includes(normalizeString(this.cliente.mail))
    },
    dniExiste(){
      return this.dniClientes.includes(parseInt(this.cliente.dni));
    },
    nombreValido() {
      return (
        this.cliente.nombreApellido.length > 0 &&
        /^[A-Za-zÀ-ÿ\s]+$/.test(this.cliente.nombreApellido)
      );
    },
    dniValido() {
      return this.cliente.dni.length == 8 && /^\d+$/.test(this.cliente.dni);
    },
    mailValido() {
      return (
        this.cliente.mail.length > 5 &&
        this.cliente.mail.includes("@") &&
        this.cliente.mail.includes(".")
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
      return (
        this.nombreValido &&
        this.dniValido &&
        !this.mailExiste &&
        this.mailValido &&
        !this.dniExiste &&
        this.telefonoValido &&
        this.direccionValida
      );
    },
  },
};
</script>
