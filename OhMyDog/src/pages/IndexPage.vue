<template>
  <div class="row" style="height: 100vh; max-height: 100vh">
    <!-- Menú lateral -->
    <div
      class="flex-column col-2 bg-primary shadow-2"
      style="max-width: 35vh; height: 100vh; max-height: 100vh"
    >
      <q-img src="logotipo" />

      <div class="q-pa-md text-center text-white bg-accent">
        ROL ACTUAL: {{ roles[store.rol+1]}}
      </div>

      <q-tabs
        v-model="store.tab"
        inline-label
        vertical
        flat
        class="q-pt-sm bg-primary text-white"
        style="max-height: 60vh"
      >
        <q-tab name="Quienes Somos" icon="ion-home" label="Quienes Somos" />
        <q-tab v-if="store.rol > 0" name="Mi Perfil" icon="ion-person" label="Mi Perfil" />
        <q-tab v-if="store.rol === 0" name="Iniciar Sesion" icon="ion-person" label="Iniciar Sesion" />
        <q-tab v-if="store.rol === 1" name="Turnos" icon="ion-calendar" label="Turnos" />
        <q-tab v-if="store.rol === 2" name="Administrar Turnos" icon="ion-calendar" label="Administrar Turnos" />
        <q-tab v-if="store.rol === 1" name="Mis Perros" icon="ion-paw" label="Mis Perros" />
        <q-tab v-if="store.rol === 2" name="Clientes" icon="ion-people" label="Clientes" />
        <q-tab v-if="store.rol < 0" name="LOG" icon="ion-people" label="LOG" />
        <q-tab name="Adopciones" icon="ion-heart" label="Adopciones" />
        <q-tab name="Paseadores" icon="ion-walk" label="Paseadores" />
        <q-tab v-if="store.rol !== 0" name="Cerrar Sesion" icon="ion-heart" label="Cerrar Sesion" />
      </q-tabs>
    </div>
    <!-- Secciones -->
    <div class="col-10 bg-white">
      <q-tab-panels
        v-model="store.tab"
        animated
        swipeable
        vertical
        transition-prev="jump-up"
        transition-next="jump-up"
      >
        <q-tab-panel name="Quienes Somos">
          <PaginaQuienesSomos />
        </q-tab-panel>

        <q-tab-panel name="Mi Perfil">
          <PaginaPerfil />
        </q-tab-panel>

        <q-tab-panel name="Iniciar Sesion">
          <PaginaIniciarSesion />
        </q-tab-panel>

        <q-tab-panel name="Turnos">
          <PaginaTurnos />
        </q-tab-panel>

        <q-tab-panel name="Administrar Turnos">
          <PaginaAdministracionTurnos />
        </q-tab-panel>

        <q-tab-panel name="Mis Perros">
          <PaginaPerros />
        </q-tab-panel>

        <q-tab-panel name="Clientes">
          <PaginaClientes />
        </q-tab-panel>

        <q-tab-panel name="Adopciones">
          <PaginaAdopciones :rol='store.rol' />
        </q-tab-panel>

        <q-tab-panel name="Paseadores">
          <PaginaPaseadores :rol='store.rol' />
        </q-tab-panel>

        <q-tab-panel name="LOG">
          <PaginaLog />
        </q-tab-panel>

        <q-tab-panel name="Cerrar Sesion">
          <PaginaCerrarSesion />
        </q-tab-panel>

      </q-tab-panels>
    </div>
  </div>
</template>

<script>

const listaRoles = ["Administrador","Visitante","Cliente","Veterinario"];

import { defineComponent, reactive } from "vue";
import { ref } from "vue";
import PaginaQuienesSomos from "../components/PaginaQuienesSomos.vue";
import PaginaIniciarSesion from "../components/PaginaIniciarSesion.vue";
import PaginaTurnos from "../components/PaginaTurnos.vue";
import PaginaAdministracionTurnos from "../components/PaginaAdministracionTurnos.vue";
import PaginaClientes from "../components/PaginaClientes.vue";
import PaginaPerros from "../components/PaginaPerros.vue";
import PaginaAdopciones from "../components/PaginaAdopciones.vue";
import PaginaPaseadores from "../components/PaginaPaseadores.vue";
import PaginaPerfil from "../components/PaginaPerfil.vue";
import PaginaLog from "../components/PaginaLog.vue";
import PaginaCerrarSesion from "../components/PaginaCerrarSesion.vue";
import { useStore } from "../pinia/store.js";
import { checkTokenHome } from "../functions/check.js";

export default defineComponent({
  name: "IndexPage",
  components: {
    PaginaQuienesSomos,
    PaginaIniciarSesion,
    PaginaTurnos,
    PaginaAdministracionTurnos,
    PaginaClientes,
    PaginaPerros,
    PaginaAdopciones,
    PaginaPaseadores,
    PaginaPerfil,
    PaginaLog,
    PaginaCerrarSesion,
  },
  setup() {
    const data = reactive({
      splitterModel: ref(20),
      store: useStore(),
      roles: listaRoles,
    });
    return data;
  },
  mounted() {
    checkTokenHome();
  },
});
</script>
