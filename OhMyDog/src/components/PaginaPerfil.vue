<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div
    class="bg-white column no-wrap col-10 items-center full-height full-width"
  >

    <div
      class="flex row q-mx-xl justify-start items-center"
      style="height: 4em"
    >
      <div class="self-start titulo text-center text-h4 text-bold text-primary">
        Mi perfil
      </div>

    </div>
    <div>
    <q-banner
      :message="message"
      :type="type"
      :timeout="timeout"
      @hide="hideBanner"
    ></q-banner>
    </div>
    <q-card class="my-card q-mt-lg" style="width: 90%; height: max-content">
      <q-separator />
      <q-card-section class="row justify-between bg-secondary">
        <div class="textoPerfil q-px-xl">{{ misDatos.NOMBREAPELLIDO }}</div>
        <div class="text-overline text-white q-px-xl">
          Registrado desde: {{ fechaRegistro }}
        </div>
      </q-card-section>
      <q-card-section class="column justify-start">
        <div class="textoTituloPerfil q-pb-sm">Mis datos</div>
        <div class="row q-py-sm">
          <div class="textoTituloPosteo q-pl-lg">Nombre y apellido:</div>
          <div class="q-px-md">{{ misDatos.NOMBREAPELLIDO }}</div>
        </div>
        <div class="row q-py-sm">
          <div class="textoTituloPosteo q-pl-lg">DNI:</div>
          <div class="q-px-md">{{ misDatos.DNI }}</div>
        </div>
        <div v-if="rol === 1" class="row q-py-sm">
          <div class="textoTituloPosteo q-pl-lg">Dirección:</div>
          <div class="q-px-md">{{ misDatos.DIRECCION }}</div>
        </div>
        <div class="textoTituloPerfil q-py-sm">Contacto</div>
        <div class="row q-py-sm">
          <div class="textoTituloPosteo q-pl-lg">Mail:</div>
          <div class="q-px-md">{{ misDatos.MAIL }}</div>
        </div>
        <div class="row q-py-sm">
          <div class="textoTituloPosteo q-pl-lg">Teléfono:</div>
          <div class="q-px-md">{{ misDatos.TELEFONO }}</div>
        </div>
      </q-card-section>
      <q-separator />
      <q-card-actions class="q-py-lg row justify-end q-px-xl">
        <!-- <q-btn class="textoBoton q-mx-md" > Editar perfil </q-btn> -->
        <q-btn v-if="true" class="textoBoton q-mx-md" @click="mostrarPopup = true" > Cambiar contraseña </q-btn>
        <q-btn class="textoBoton" @click="cerrarSesion()"> Cerrar Sesión </q-btn>
      </q-card-actions>
    </q-card>
    <q-dialog ref="popup1" v-model="mostrarPopup">
      <FormCambiarContrasenia
      @mostrarMensaje0="showBanner"
      @close-popup="cerrarPopup"/>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { checkToken } from "../functions/check.js";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";
import { LocalStorage } from "quasar";
import FormCambiarContrasenia from "./formularios/formCambiarContrasenia.vue";
import { QBanner } from "quasar";

export default defineComponent({
  name: "PaginaPerfil",
  components: { FormCambiarContrasenia },
  setup() {
    var message;
    var timeout;
    var type;
    const rol = useStore().rol;
    const misDatos = ref({});
    const fechaRegistro = ref('')
    const mostrarPopup = ref("false");
    const traerDatos = async () => {
      let url = "";
      if (rol === 1) {
        url = "/cliente/getCliente";
      } else url = "/veterinario/getVeterinario";
      try {
        const response = await api.post(`${url}`, {
          dni: useStore().dni,
        });
        misDatos.value = response.data;
        let regDate = new Date(response.data.FECHAREGISTRO)
        fechaRegistro.value = `${regDate.getDate()}-${regDate.getMonth() + 1}-${regDate.getFullYear()}`
      } catch {
        console.log("No se pudo solicitar la operacion correspondiente");
      }
    };
    const cerrarPopup = () => {
      console.log("Deberia cerrar")
      mostrarPopup.value = false;
    };

    return {
      rol,
      misDatos,
      traerDatos: ref(traerDatos),
      fechaRegistro,
      mostrarPopup,
      store: useStore(),
      message,
      type,
      timeout,
      cerrarPopup,
    };
  },
  methods: {
    async cerrarSesion() {
      try {
        const response = await api.post("/logout", {
          token: LocalStorage.getItem("token"),
        });
        if (response) {
          this.store.setRol(0);
          this.store.setTab("Iniciar Sesion");
          LocalStorage.clear();
        }
      } catch (error) {
        console.error(error);
      }
    },
    showBanner(message, type, timeout) {
      this.message = message
      this.type = type
      this.timeout = timeout
    },
  },
  mounted() {
    checkToken();
    this.traerDatos();
  },
});
</script>
