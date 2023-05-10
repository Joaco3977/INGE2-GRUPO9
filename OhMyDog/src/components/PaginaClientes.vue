<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary q-pt-md"> CLIENTES </div>
    <q-card flat class="column">
      <q-btn color="accent" @click="mostrarPopup = true" class="q-ma-md self-end" style="width: 15em">
        <div class="textoBoton">Agregar cliente</div>
      </q-btn>
    
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
                <!-- <q-form class="q-pa-xl" @submit.prevent="registrarCliente">
                  <q-input class="q-px-xl" v-model="clienteAgregarDni" label="DNI" type="number" />
                  <q-input class="q-px-xl" v-model="clienteAgregarNombreApellido" label="Nombre y Apellido" type="text" />
                  <q-input class="q-px-xl" v-model="clienteAgregarMail" label="Correo electrónico" type="email" />
                  <q-input class="q-px-xl" v-model="clienteAgregarTelefono" label="Telefono" type="number" />
                  <q-input class="q-px-xl" v-model="clienteAgregarDireccion" label="Direccion" type="text" />
                  <q-btn push class="q-my-md q-mx-xl" color="accent" type="submit" label="Registrar Cliente" />
                </q-form> -->
              </div>
            </div>
          </q-tab-panel>

          <q-tab-panel name="Buscar Cliente">
            <div class="full-width row items-center">
              <q-search v-model="dniFiltrar" placeholder="Buscar Cliente por DNI" ></q-search>
              <TarjetaCliente
                v-for="(cliente, dni) in clientesFiltrados" :key="dni"
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
    </q-card>

    <q-dialog v-model="mostrarPopup"> 
      <div class="full-width row items-center bg-white">
              <div class="q-pa-md " style="width:50rem">
                <div class="textoTituloTarjeta text-accent q-pt-md"> Agregar Cliente</div>
                <q-form class="q-pa-md" @submit.prevent="registrarCliente">
                  <q-input class="q-px-xl" label="DNI" v-model="clienteAgregarDni"
                     maxlength="8"
                    :rules= "[ val => !!val | 'Es necesario completar este campo',
                             val => val.length != 8 | 'Formato de DNI incorrecto',
                             val => /^\d+$/.test(val) == true ]"

                  />
                  <!-- <q-input ref="inputRef" class="q-px-xl" v-model="clienteAgregarDni" label="DNI" 
                    type="number" mask="########" maxlenght='8' 
                    :rules="[
          val => !!val || '* Es necesario completar este campo',
          val => val.length < 8 || 'Formato de DNI incorrecto',
        ]" lazy-rules
        hint="Validation starts after first blur"
                  />  -->
                  <!-- <q-input class="q-px-xl" v-model="clienteAgregarNombreApellido" label="Nombre y Apellido" type="text" />
                  <q-input class="q-px-xl" v-model="clienteAgregarMail" label="Correo electrónico" type="email" />
                  <q-input class="q-px-xl" v-model="clienteAgregarTelefono" label="Telefono" type="tel" mask="(###) ### - ####" />
                  <q-input class="q-px-xl" v-model="clienteAgregarDireccion" label="Direccion" type="text" />
                  <q-btn push class="q-mt-lg q-mx-xl" color="accent" type="submit" label="Registrar Cliente" /> -->
                </q-form>
              </div>
            </div>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from 'vue';
import { api } from '../boot/axios.js';
import { useStore } from '../pinia/store.js'
import { LocalStorage } from "quasar";
import TarjetaCliente from "./tarjetas/TarjetaCliente.vue";
import { checkToken } from "../functions/check.js"
import { QDialog } from 'quasar'


export default defineComponent({
  name: "PaginaClientes",
  components: {
    TarjetaCliente,
    QDialog,
  },
  setup() {
    const inputRef = ref(null)

    const tab = ref('Agregar Cliente')
    const store = useStore();
    const clientes = reactive([]);
    const clientesFiltrados = ref([]);
    const dniFiltrar = ref('');
    
    const clienteAgregarNombreApellido = ref('');
    const clienteAgregarMail = ref('');
    const clienteAgregarTelefono = ref('');
    const clienteAgregarDireccion = ref('');

    const registrarCliente = async () => {
      try {
        const response = await api.post("/cliente/addCliente", {
          token: LocalStorage.getItem('token'),
          cliente: {
            dni: clienteAgregarDni.value,
            nombreApellido: clienteAgregarNombreApellido.value,
            mail: clienteAgregarMail.value,
            telefono: clienteAgregarTelefono.value,
            direccion: clienteAgregarDireccion.value,
          }
        });
      } catch (error) {
        console.error(error);
      }
    };

    const loadClientes = async () => {
      try {
        const response = await api.get("/cliente/getClientes")
        if (response !== false) {
          clientes.value = response.data;
          clientesFiltrados.value = response.data;
        }
      } catch (error) {
        console.error(error);
      }
    };

    watch(dniFiltrar, (nuevoValor, valorAnterior) => {
      this.filtrarClientes(nuevoValor, clientes);
    });

    const filtrarClientes = () => {
      const query = dniFiltrar.value
      clientesFiltrados.value = clientes.value.filter(
        (cliente) => cliente.dni.includes(query)
      );
    };

    return {
      tab,
      clientes,
      clientesFiltrados,
      dniFiltrar,
      clienteAgregarDni: ref(''),
      clienteAgregarNombreApellido,
      clienteAgregarMail,
      clienteAgregarTelefono,
      clienteAgregarDireccion,
      loadClientes,
      registrarCliente,
      filtrarClientes,

      mostrarPopup: ref(false),
      inputRef,
    };
  },
  mounted() {
    checkToken()
  }
});
</script>
