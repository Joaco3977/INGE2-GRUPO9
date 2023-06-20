<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Editar cliente
        </div>
      </q-card-section>
      <q-card-section class="q-pt-md">
        <q-form class="q-pa-md" @submit.prevent="submitForm">
          <q-input
            ref="inputRef"
            class="q-px-xl"
            label="DNI"
            type="text"
            v-model="cliente.dni"
            :value="dni"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.nombreApellido"
            label="Nombre y Apellido"
            type="text"
            :value="nombreApellido"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.mail"
            label="Correo electrónico"
            type="email"
            :value="mail"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.telefono"
            label="Teléfono"
            type="tel"
            :value="telefono"
          />
          <q-input
            class="q-px-xl"
            v-model="cliente.direccion"
            label="Dirección"
            type="text"
            :value="direccion"
          />
          <ul class="q-mx-md q-py-xs">
          <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
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
              label="Editar cliente"
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
  name: "formCliente",
  emits: ["registrarCliente"],
  components:{
  },
   props: {
    dni:String,
    nombreApellido:String,
    mail:String,
    telefono:String,
    direccion:String,
    mailsClientes: {
      type: Array,
      required: true,
    },
    mailsVeterinarios: {
      type: Array,
      required: true,
    },
    dniClientes: {
      type: Array,
      required: true,
    },
  },
  setup(props, { emit }) {
    const cliente = ref({
      dni: props.dni,
      nombreApellido:props.nombreApellido,
      mail: props.mail,
      telefono: props.telefono,
      direccion: props.direccion,
      dniA: props.dni,
    });
    const dniA= cliente.value.dni;
    const mailA=  cliente.value.mail;

    const submitForm = () => {
      emit("editarCliente", cliente.value);
    };

    return {
      cliente,
      submitForm,
      dniA,
      mailA
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
      if (this.cliente.mail === this.mailA){
        return false
      }else{
      return this.mailsClientes.includes(normalizeString(this.cliente.mail)) || this.mailsVeterinarios.includes(normalizeString(this.cliente.mail))}
    },
    dniExiste(){
      if (parseInt(this.cliente.dni) === parseInt(this.dniA)){
        return false
      }else{
      return this.dniClientes.includes(parseInt(this.cliente.dni))};
    },
    nombreValido() {
      return (
        this.cliente.nombreApellido.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.cliente.nombreApellido)
      );
    },
    dniValido() {
      return this.cliente.dni.toString().length === 8 && /^\d+$/.test(this.cliente.dni);
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
