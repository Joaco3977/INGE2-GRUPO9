<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-pt-md">ADOPCIONES {{rol}}</div>


    <q-tabs
          v-model="tab"
          dense
          class="text-grey q-pt-lg"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
          <q-tab name="Agregar Cliente" label="Agregar Cliente" />
          <q-tab @click="loadClientes" name="Buscar Cliente" label="Buscar Cliente" />

    </q-tabs>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 70vh"
      class="bg-white "
    >

      <q-card flat>


        <q-separator />

        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="Agregar Cliente">
            <div class="full-width row items-center">
              <h3>Agregar Cliente</h3>
            </div>
          </q-tab-panel>

          <q-tab-panel name="Buscar Cliente">
            <div class="full-width row items-center">
              <TarjetaCliente
                v-for="(cliente, dni) in data.clientes" :key="dni"
                :dni='cliente.DNI'
                :nombreaApellido='cliente.NOMBREAPELLIDO'
                :mail='cliente.MAIL'
                :telefono='cliente.TELEFONO'
                :direccion='cliente.DIRECCION'
              />
            </div>

          </q-tab-panel>
        </q-tab-panels>

      </q-card>

    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent, ref, reactive } from "vue";
import { api } from '../boot/axios.js';
import { useStore } from '../pinia/store.js'
import { LocalStorage } from "quasar";
import TarjetaCliente from "./tarjetas/TarjetaCliente.vue";
import { checkToken } from "../functions/check.js"

export default defineComponent({
  name: "PaginaClientes",
  components: {
    TarjetaCliente,
  },
  setup() {
    const data = reactive({
      store: useStore(),
      clientes: []
    });

    return { data }
  },
  methods: {
    async loadClientes() {
    try {
      const response = await api.post("/cliente/getClientes", {
        token: LocalStorage.getItem('token')
      });
      console.log('Response: ', response.data)
      if (response === false) {
        this.data.store.setRol(0);
        this.data.store.setTab('Iniciar Sesion');
        LocalStorage.clear()
      } else {
        this.data.clientes = response.data;
      }
    } catch (error) {
      console.error(error);
    }
    }
  },
  mounted() {
    checkToken()
  }
});
</script>
