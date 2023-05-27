<template>
  <div class="bg-white" style="width: full; max-height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <!-- titulo -->
      <div class="titulo text-center text-h4 text-bold text-primary">
        CLIENTES
      </div>
      <!-- botón agregar cliente -->
      <q-btn
        @click="mostrarPopup = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Agregar cliente</div>
      </q-btn>
    </div>

    <q-card flat stretch class="column">
      <div class="row q-mx-lg q-py-sm justify-start items-center" style="width: max-content">
        <div class="">
          Ingresar el DNI o nombre del cliente:
        </div>
        <q-input
        filled
          class="q-pl-sm q-pr-xl"
          v-model="dniFiltrar"
          :dense="dense"
          placeholder="n° DNI o nombre"
          style="width: 20rem"
        >
          <template v-slot:append>
            <q-icon name="ion-search" />
          </template>
        </q-input>
      </div>

      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 87vh"
        class="bg-white"
      >
        <q-card flat>
          <div class="full-width row items-center q-py-md">
            <TarjetaCliente
              @ejecutarFuncion="eliminarCliente"
              v-for="(cliente, dni) in clientesFiltrados"
              :key="dni"
              :dni="cliente.DNI"
              :nombreaApellido="cliente.NOMBREAPELLIDO"
              :mail="cliente.MAIL"
              :telefono="cliente.TELEFONO"
              :direccion="cliente.DIRECCION"
            />
          </div>
        </q-card>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormCliente @registrarCliente="registrarCliente" :mailsClientes="mailsClientes" />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import TarjetaCliente from "./tarjetas/TarjetaCliente.vue";
import { checkToken } from "../functions/check.js";
import { QDialog } from "quasar";
import FormCliente from "./formularios/formCliente.vue"

export default defineComponent({
  name: "PaginaClientes",
  components: {
    TarjetaCliente,
    QDialog,
    FormCliente,
  },
  setup() {
    const inputRef = ref(null);

    const tab = ref("Buscar Cliente");

    const clientes = reactive([]);
    const clientesFiltrados = ref([]);
    const mailsClientes = ref([]);
    const dniFiltrar = ref("");

    const registrarCliente = async (cliente) => {
      try {
        const response = await api.post("/cliente/addCliente", {
          dniVet: useStore().dni,
          cliente: {
            dni: cliente.dni,
            nombreApellido: cliente.nombreApellido,
            mail: cliente.mail,
            telefono: cliente.telefono,
            direccion: cliente.direccion,
          },
        });
      } catch (error) {
        console.error(error);
      }
    };

    const loadClientes = async () => {
      try {
        const response = await api.post("/cliente/getClientes", {
          dni: useStore().dni,
          rol: useStore().rol,
        });
        if (response !== false) {
          clientes.value = response.data;
          clientesFiltrados.value = response.data; // en clientes mantendria todos, mientras que los q se muestran en pantalla los tengo el el clientesFiltrados!
          mailsClientes.value = response.data.map((cliente) => cliente.MAIL);
          console.log("Los mails: ", mailsClientes.value)
        }
      } catch (error) {
        console.error(error);
      }
    };

    watch(dniFiltrar, (nuevoValor, valorAnterior) => {
      filtrarClientes(nuevoValor);
    });

    const filtrarClientes = (dni) => {
      clientesFiltrados.value = clientes.value.filter((cliente) =>
        cliente.DNI.toString().includes(dni.toString())
      );
    };

    async function eliminarCliente(dni) {
      try {
        await api.post("cliente/deleteCliente", {
          dniVet: useStore().dni,
          dni: dni,
        });
        loadClientes();
      } catch {
        console.error("NO SE PUDO ELIMINAR CLIENTE");
      }
    }

    return {
      tab,
      clientes,
      clientesFiltrados,
      mailsClientes,
      dniFiltrar,
      loadClientes,
      registrarCliente,
      filtrarClientes,
      eliminarCliente,

      mostrarPopup: ref(false),
      inputRef,
    };
  },
  mounted() {
    checkToken();
    this.loadClientes();
  },
});
</script>
