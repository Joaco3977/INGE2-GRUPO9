<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
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
          <q-tab name="Buscar Cliente" label="Buscar Cliente" />

    </q-tabs>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 70vh"
      class="bg-white "
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <!-- -->
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
              <ListaCliente
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
      <!-- -->

      <!-- los veterinarios tendrían una vista, los clientes otras Y LOS VISITANTES OTRAS??

      ahora estoy pensando en texto...
      - visitante: ver
      - cliente: ver, subir, ver subidos ( nota: usar dos columnas )
      - vet: ver editar -->

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent, ref, reactive } from "vue";
import { api } from '../boot/axios.js';
import { useStore } from '../pinia/store.js'
import { LocalStorage } from "quasar";

export default defineComponent({
  name: "PaginaClientes",
  components: {

  },
  setup() {
    const data = reactive({
      store: useStore(),
      clientes: []
    });

    const loadClientes = async () => {
      try {
        const response = await api.post("/cliente/getClientes", {
          token: LocalStorage.getItem('token')
        });
        if (response === false) {
          this.store.setRol(0);
          this.store.setTab('Iniciar Sesion');
          LocalStorage.clear()
        } else {
          this.clientes = response;
          console.log('Clientes: ', this.clientes)
        }
      } catch (error) {
        console.error(error);
      }
    };

    return { data, loadClientes}
  },
  mounted() {
    this.loadClientes()
  }
});
</script>
