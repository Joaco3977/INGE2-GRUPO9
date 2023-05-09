<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-pt-md"> ADMINISTRAR CLIENTES </div>


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
              <div class="q-pa-xl " style="width:50vw; height:80vh">
                <q-form class="q-pa-xl" @submit.prevent="registrarCliente">
                  <q-input class="q-px-xl" v-model="clienteAgregarDni" label="DNI" type="number" />
                  <q-input class="q-px-xl" v-model="clienteAgregarNombreApellido" label="Nombre y Apellido" type="text" />
                  <q-input class="q-px-xl" v-model="clienteAgregarMail" label="Correo electrónico" type="email" />
                  <q-input class="q-px-xl" v-model="clienteAgregarTelefono" label="Telefono" type="number" />
                  <q-input class="q-px-xl" v-model="clienteAgregarDireccion" label="Direccion" type="text" />
                  <q-btn push class="q-my-md q-mx-xl" color="accent" type="submit" label="Registrar Cliente" />
                </q-form>
              </div>
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
import { defineComponent, ref, reactive, render } from "vue";
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
      clientes: [],
      clienteAgregarDni: '',
      clienteAgregarNombreApellido: '',
      clienteAgregarMail: '',
      clienteAgregarTelefono: '',
      clienteAgregarDireccion: '',
    });
    return { data }
  },
  methods: {
    async loadClientes() {
      try {
        const response = await api.get("/cliente/getClientes")
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
    },
    async registrarCliente() {
      try {
        const response = await api.post("/cliente/addCliente", {
          cliente: {
            dni: 223223,
            nombreaApellido: "fd",
            mail:"ren.sabee@gmail.com",
            telefono: 23,
            direccion: 23,
          }
        });
        console.log('Response: ', response.data)
        if (response === false) {
          this.data.store.setRol(0);
          this.data.store.setTab('Iniciar Sesion');
          LocalStorage.clear();
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
