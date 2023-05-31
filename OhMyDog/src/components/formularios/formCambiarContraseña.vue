<template>
    <div class="flex">
      <q-card style="width: 40rem">
        <q-card-section class="bg-secondary">
          <div class="text-h5 text-uppercase text-white text-center text-bold" >Cambiar contraseña</div>
        </q-card-section>
  
        <q-card-section class="q-pt-md">
          <q-form  class="q-gutter-md">
            <q-input
              class="q-px-lg"
              filled
              type="password"
              v-model="contraseñaA"
              label="Contraseña actual"
            />
  
            <q-input
              class="q-px-lg"
              filled
              type="password"
              v-model="contraseñaNuevaA"
              label="Nueva contraseña"
            />
  
            <q-input
              class="q-px-lg"
              filled
              type="password"
              v-model="contraseñaNuevaB"
              label="Repita la nueva contraseña"
            />
            <ul class="q-mx-md q-py-xs">
                <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
                    {{ mnsj }}
                </li>
            </ul>
            <div class="row justify-end">
              <q-btn label="Cambiar contraseña"  :disabled="!camposValidos" type="submit" color="accent" />
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
  import { useStore } from "../../pinia/store.js";
  import { api } from "../../boot/axios.js";

  export default defineComponent({
    name: "formCambiarContraseña",
    components: {},
    setup() {
        const contraseñaA = ref("")
        const contraseñaNuevaA = ref("")
        const contraseñaNuevaB = ref("")
        
        const chequeoPass = async ()=>{
            console.log("chequeo")
        try {
            var response = await api.post("/passwordCheck", {
                mail: useStore.mail,
                password: contraseñaA.value,
            });
            return response.check
        } catch (error) {
            console.error(error);
            }
        }

      return {
        contraseñaA,
        contraseñaNuevaA,
        contraseñaNuevaB,
        chequeoPass,
      };
    },
    computed: {
        mensajeError() {
        let sError = [];
        if (!this.contraseñasIguales) {
            sError.push("Las contraseñas no son iguales");
        }
        if (this.constraseñaCorrecta) {
            sError.push("La contraseña actual no es correcta");
        }
        return sError;
        },
        contraseñasIguales(){
        return this.contraseñaNuevaA === this.contraseñaNuevaB
        },
        constraseñaCorrecta(){
        return this.chequeoPass();
        }
    },
    
    camposValidos() {
      return (
        this.constraseñaCorrecta &&
        this.contraseñasIguales
      );
    },
  },
  );
  </script>