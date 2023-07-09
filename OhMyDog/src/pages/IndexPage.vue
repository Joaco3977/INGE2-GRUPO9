<template>
  <div class="row" style="height: 100vh; max-height: 100vh">
    <!-- Menú lateral -->
    <div
      class="column col-2 bg-primary shadow-2"
      style="max-width: 40vw; height: 100vh; max-height: 100vh"
    >
      <q-img src="logotipo" />

      <q-tabs
        v-model="store.tab"
        inline-label
        vertical
        flat
        class="q-pt-sm bg-primary text-white"
        style="height:70vh"
      >
       <!-- <q-tab
          v-if="store.rol > -1"
          name="Quienes Somos"
          icon="ion-home"
          label="¿Quiénes Somos?"
        /> -->
        <q-tab
          v-if="store.rol > 0"
          name="Mi Perfil"
          icon="ion-person"
          label="Mi Perfil"
        />
        <q-tab
          v-if="store.rol === 0"
          name="Iniciar Sesion"
          icon="ion-person"
          label="Iniciar Sesion"
        />
        <q-tab
          v-if="store.rol === 1"
          name="Turnos"
          icon="ion-calendar"
          label="Turnos"
        />
        <q-tab
          v-if="store.rol === 2"
          name="Administrar Turnos"
          icon="ion-calendar"
          label="Turnos"
        />
        <q-tab
          v-if="store.rol === 1"
          name="Mis Perros"
          icon="ion-paw"
          label="Mis Perros"
        />
        <q-tab
          v-if="store.rol === 2"
          name="Clientes"
          icon="ion-people"
          label="Clientes"
        />
        <q-tab
          v-if="store.rol < 0"
          name="Veterinarios"
          icon="ion-people"
          label="Veterinarios"
        />

        <q-tab v-if="store.rol < 0" name="LOG" icon="ion-folder" label="LOG" />
        <q-tab
          v-if="store.rol > -1"
          name="Adopciones"
          icon="ion-heart"
          label="Adopciones"
        />
        <q-tab
          v-if="store.rol > -1"
          name="Perros Perdidos"
          icon="ion-search"
          label="Perros perdidos"
        />
        <q-tab
          v-if="store.rol === 1"
          name="Cruza"
          icon="ion-rose"
          label="Cruza"
        />
        <q-tab
          v-if="store.rol > -1"
          name="Paseadores"
          icon="ion-walk"
          label="Paseadores"
        />
        <q-tab
          v-if="store.rol > -1"
          name="Donaciones"
          icon="ion-hand"
          label="Donaciones"
        />
        <q-tab
          v-if="store.rol < 0"
          name="Registro Donaciones"
          icon="ion-hand"
          label="Registro Donaciones"
        />

        <!-- <q-tab
          v-if="store.rol === 2"
          name="Responder Consultas"
          icon="ion-people"
          label="Responder Consultas"
        />
        <q-tab
          v-if="store.rol === 1"
          name="Consultas"
          icon="ion-people"
          label="Consultas"
        /> -->

        <q-tab
          v-if="store.rol > -1"
          name="Veterinarias de turno"
          icon="calendar_month"
          label="Veterinarias de turno"
        />
      </q-tabs>

      <q-btn
        flat
        v-if="store.rol === -1"
        @click="cerrarSesion()"
        class="bg-accent q-py-md text-white"
      >
        <div>Cerrar Sesión</div>
      </q-btn>
    </div>
    <!-- Secciones -->
    <div class="col-10 bg-white full-height">
      <q-tab-panels
        class="full-height"
        v-model="store.tab"
        animated
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

        <q-tab-panel v-if="store.rol === -1" name="Veterinarios">
          <PaginaVeterinarios />
        </q-tab-panel>

        <q-tab-panel name="Adopciones">
          <PaginaAdopciones :rol="store.rol" />
        </q-tab-panel>

        <q-tab-panel name="Perros Perdidos">
          <PaginaPerdidos :rol="store.rol" />
        </q-tab-panel>

        <q-tab-panel name="Cruza">
          <PaginaCruza />
        </q-tab-panel>

        <q-tab-panel name="Paseadores">
          <PaginaPaseadores :rol="store.rol" />
        </q-tab-panel>

        <q-tab-panel name="Donaciones">
          <PaginaDonaciones />
        </q-tab-panel>

        <q-tab-panel v-if="store.rol === -1" name="LOG">
          <PaginaLog />
        </q-tab-panel>

        <q-tab-panel v-if="store.rol === 1" name="Consultas">
          <PaginaConsultaCliente />
        </q-tab-panel>

        <q-tab-panel v-if="store.rol === 2" name="Responder Consultas">
          <PaginaConsultaVeterinario />
        </q-tab-panel>

        <q-tab-panel v-if="store.rol === -1" name="Registro Donaciones">
          <PaginaRegistroDonaciones />
        </q-tab-panel>

        <q-tab-panel name="Veterinarias de turno">
          <PaginaVetsDeTurno />
        </q-tab-panel>
      </q-tab-panels>
    </div>
  </div>
</template>

<script>
const listaRoles = ["Administrador", "Visitante", "Cliente", "Veterinario"];

import { defineComponent, reactive } from "vue";
import { ref } from "vue";
import PaginaQuienesSomos from "../components/PaginaQuienesSomos.vue";
import PaginaIniciarSesion from "../components/PaginaIniciarSesion.vue";
import PaginaTurnos from "../components/PaginaTurnos.vue";
import PaginaAdministracionTurnos from "../components/PaginaAdministracionTurnos.vue";
import PaginaConsultaCliente from "src/components/PaginaConsultaCliente.vue";
import PaginaConsultaVeterinario from "src/components/PaginaConsultaVeterinario.vue";
import PaginaClientes from "../components/PaginaClientes.vue";
import PaginaPerros from "../components/PaginaPerros.vue";
import PaginaPerdidos from "../components/PaginaPerdidos.vue";
import PaginaAdopciones from "../components/PaginaAdopciones.vue";
import PaginaPaseadores from "../components/PaginaPaseadores.vue";
import PaginaPerfil from "../components/PaginaPerfil.vue";
import PaginaLog from "../components/PaginaLog.vue";
import PaginaVeterinarios from "src/components/PaginaVeterinarios.vue";
import PaginaDonaciones from "../components/PaginaDonaciones.vue";
import PaginaRegistroDonaciones from "../components/PaginaRegistroDonaciones.vue";
import PaginaCruza from "../components/PaginaCruza.vue"
import PaginaVetsDeTurno from '../components/PaginaVetsDeTurno.vue'
import { useStore } from "../pinia/store.js";
import { checkTokenHome } from "../functions/check.js";
import { api } from "../boot/axios.js";
import { LocalStorage } from "quasar";

export default defineComponent({
  name: "IndexPage",
  components: {
    PaginaQuienesSomos,
    PaginaIniciarSesion,
    PaginaTurnos,
    PaginaAdministracionTurnos,
    PaginaConsultaCliente,
    PaginaConsultaVeterinario,
    PaginaClientes,
    PaginaPerros,
    PaginaAdopciones,
    PaginaPerdidos,
    PaginaPaseadores,
    PaginaPerfil,
    PaginaLog,
    PaginaVeterinarios,
    PaginaAdopciones,
    PaginaDonaciones,
    PaginaRegistroDonaciones,
    PaginaCruza,
    PaginaVetsDeTurno,
  },
  setup() {
    const data = reactive({
      splitterModel: ref(20),
      store: useStore(),
      roles: listaRoles,
    });
    return data;
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
  },
  mounted() {
    checkTokenHome();
  },
});
</script>
