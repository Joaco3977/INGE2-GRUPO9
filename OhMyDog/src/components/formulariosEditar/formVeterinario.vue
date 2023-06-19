<template>
    <div class="flex">
      <q-card style="width: 40rem">
        <q-card-section class="bg-secondary">
          <div class="text-h5 text-uppercase text-white text-center text-bold">
            Editar veterinario
          </div>
        </q-card-section>
        <q-card-section class="q-pt-md">
          <q-form class="q-pa-md" @submit.prevent="submitForm">
            <q-input
              ref="inputRef"
              class="q-px-xl"
              label="DNI"
              v-model="veterinario.dni"
            />
            <q-input
              class="q-px-xl"
              v-model="veterinario.nombreApellido"
              label="Nombre y Apellido"
              type="text"
            />
            <q-input
              class="q-px-xl"
              v-model="veterinario.mail"
              label="Correo electrónico"
              type="email"
            />
            <q-input
              class="q-px-xl"
              v-model="veterinario.telefono"
              label="Teléfono"
              type="tel"
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
    name: "formVeterinario",
    components: {},
    props: {
      dni: String,
      nombreApellido: String,
      mail: String,
      telefono: String,
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
      dniVeterinarios: {
        type: Array,
        required: true,
      },
    },
    setup(props, { emit }) {
      const veterinario = ref({
        dni: props.dni,
        nombreApellido: props.nombreApellido,
        mail: props.mail,
        telefono: props.telefono,
        dniA: props.dni,
      });
      const dniA = veterinario.value.dni;
      const mailA = veterinario.value.mail;
  
      const submitForm = () => {
        emit("editarVeterinario", veterinario.value);
      };
  
      return {
        veterinario,
        submitForm,
        dniA,
        mailA,
      };
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
        if (this.dniExiste) {
          sError.push("Una cuenta con este DNI ya está registrada");
        }
        if (!this.mailValido) {
          sError.push("Ingrese un mail válido");
        }
        if (this.mailExiste) {
          sError.push("Una cuenta con este mail ya está registrada");
        }
        if (!this.telefonoValido) {
          sError.push("Ingrese un teléfono válido");
        }
        return sError;
      },
      mailExiste() {
        if (this.veterinario.mail == this.mailA){
            return false
        }else{
        return (
          this.mailsClientes.includes(normalizeString(this.veterinario.mail)) ||
          this.mailsVeterinarios.includes(normalizeString(this.veterinario.mail))
        );
      }},
      dniExiste() {
        if(this.veterinario.dni == this.dniA){
            return false
        }else{
        return (this.dniClientes.includes(parseInt(this.veterinario.dni)) || this.dniVeterinarios.includes(parseInt(this.veterinario.dni)));
      }},
      nombreValido() {
        return (
            this.veterinario.nombreApellido.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.veterinario.nombreApellido)
        );
      },
      dniValido() {
        return (
          this.veterinario.dni.toString().length == 8 && /^\d+$/.test(this.veterinario.dni)
        );
      },
      mailValido() {
        return (
          this.veterinario.mail.toString().length > 5 &&
          this.veterinario.mail.includes("@") &&
          this.veterinario.mail.includes(".")
        );
      },
      telefonoValido() {
        return (
          this.veterinario.telefono.length > 6 &&
          /^\d+$/.test(this.veterinario.telefono)
        );
      },
      camposValidos() {
        return (
          this.nombreValido &&
          this.dniValido &&
          !this.mailExiste &&
          this.mailValido &&
          !this.dniExiste &&
          this.telefonoValido
        );
      },
    },
  };
  </script>