<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Cambiar contraseña
        </div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <q-form class="q-gutter-md">
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
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              label="Cambiar contraseña"
              @click="cambiarContraseña"
              :disabled="!camposValidos"
              color="accent"
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">
            Su contraseña actual no pudo ser actualizada
          </div>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Ok" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useStore } from "../../pinia/store.js";
import { api } from "../../boot/axios.js";

export default defineComponent({
  name: "formCambiarContrasenia",
  setup(props, { emit }) {
    const confirmar = ref(false);
    const contraseñaA = ref("");
    const contraseñaNuevaA = ref("");
    const contraseñaNuevaB = ref("");

    const chequeoPass = async () => {
      try {
        var response = await api.post("/passwordCheck", {
          mail: localStorage.getItem("mail"),
          password: contraseñaA.value,
        });
        console.log("todo ok");
        emit("close-popup"); // Emit the close-popup event
        return response.data.check;
      } catch (error) {
        console.error(error);
        console.log("Entre acá");
        confirmar.value = true;
      }
    };

    function ejecutarFuncionPadre(message, type, timeout) {
      emit("mostrarMensaje", message, type, timeout);
    };

    const cambiarContraseña = async () => {
      await chequeoPass().then(async (response) => {
        if (response === true) {
          if (useStore().rol === 2) {
            response = await api
              .post("/cambiarContraseniaVet", {
                mail: localStorage.getItem("mail"),
                password: contraseñaNuevaA.value,
              })
              .then(() => {
                ejecutarFuncionPadre("Hecho", "positive", 2000);
              });
          } else {
            response = await api
              .post("/cambiarContraseniaCli", {
                mail: localStorage.getItem("mail"),
                password: contraseñaNuevaA.value,
              })
              .then(() => {
                ejecutarFuncionPadre("Hecho", "positive", 2000);
              });
          }
        } else {
          ejecutarFuncionPadre("no Hecho", "negative", 2000);
        }
      });
    };

    return {
      confirmar,
      contraseñaA,
      contraseñaNuevaA,
      contraseñaNuevaB,
      chequeoPass,
      cambiarContraseña,
    };
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.contraseñasIguales) {
        sError.push("Las contraseñas no son iguales");
      }
      if (!this.contraseñaLongitud) {
        sError.push("La contraseña debe tener por lo menos 4 caracteres");
      }
      if (!this.contraseñasDistintas) {
        sError.push("La nueva contraseña no puede ser igual a la anterior");
      }
      if (this.contraseñasVacias) {
        sError.push("Hay campos vacios");
      }
      return sError;
    },

    contraseñasIguales() {
      return this.contraseñaNuevaA === this.contraseñaNuevaB;
    },

    contraseñaLongitud() {
      return this.contraseñaNuevaA.length >= 4;
    },

    contraseñasDistintas() {
      return this.contraseñaNuevaA != this.contraseñaA;
    },

    contraseñasVacias() {
      return (
        this.contraseñaA === undefined ||
        this.contraseñaNuevaA === undefined ||
        this.contraseñaNuevaB === undefined
      );
    },

    camposValidos() {
      return this.contraseñasDistintas && this.contraseñasIguales && this.contraseñaLongitud && !this.contraseñasVacias;
    },
  },
});
</script>
