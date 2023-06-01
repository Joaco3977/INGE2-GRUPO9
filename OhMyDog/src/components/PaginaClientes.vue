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
      <div
        class="row q-mx-lg q-py-sm justify-start items-center"
        style="width: max-content"
      >
        <div class="">Buscar por DNI:</div>
        <q-input
          filled
          class="q-pl-sm q-pr-xl"
          v-model="dniFiltrar"
          :dense="dense"
          placeholder="n° DNI"
          style="width: 20rem"
        >
          <template v-slot:append>
            <q-icon name="ion-search" />
          </template>
        </q-input>

        <div class="">Buscar por nombre:</div>
        <q-input
          filled
          class="q-pl-sm q-pr-xl"
          v-model="nombreFiltrar"
          :dense="dense"
          placeholder="Nombre o apellido"
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
        style="height: 78vh"
        class="bg-white"
      >
        <q-card flat>
          <div class="full-width row items-center q-py-md">
            <TarjetaCliente
              :ref="'losClientes'"
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
          <div
            class="row textoNoItems justify-center full-height content-center q-pa-xl"
            v-if="clientesFiltrados.length === 0"
          >
            ¡No encontramos ningún cliente!
          </div>
        </q-card>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormCliente
        @registrarCliente="registrarCliente"
        :mailsClientes="mailsClientes"
        :mailsVeterinarios="mailsVeterinarios"
        :dniClientes="dniClientes"
      />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch, getCurrentInstance } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import TarjetaCliente from "./tarjetas/TarjetaCliente.vue";
import { checkToken } from "../functions/check.js";
import { QDialog } from "quasar";
import FormCliente from "./formularios/formCliente.vue";
import { normalizeString } from "src/functions/misc";

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
    const mailsVeterinarios = ref([]);
    const dniClientes = ref([]);
    const dniFiltrar = ref("");
    const nombreFiltrar = ref("");

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
        loadClientes();
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
          mailsClientes.value = response.data.map((cliente) => normalizeString(cliente.MAIL));
          dniClientes.value = response.data.map((cliente) => cliente.DNI);
          //console.log("Los dnis: ", dniClientes.value);
        }
      } catch (error) {
        console.error(error);
      }
    };

    const loadVeterinarios = async () => {
        try {
          const response = await api.get("/veterinario/getVeterinarios");
          if (response !== false) {
            mailsVeterinarios.value = response.data.map((vet) => normalizeString(vet.MAIL));
            //console.log("los mails: ", mailsVeterinarios.value)
          }
        } catch (error) {
          console.error(error);
        }
      };

    watch(dniFiltrar, (nuevoValor, valorAnterior) => {
      filtrarClientes(nuevoValor);
    });

    watch(nombreFiltrar, (nuevoValor, valorAnterior) => {
      filtrarClientesNom(nuevoValor);
    });

    const filtrarClientes = (dni) => {
      clientesFiltrados.value = clientes.value.filter((cliente) =>
        cliente.DNI.toString().includes(dni.toString())
      );
    };

    const filtrarClientesNom = (nom) => {
      const nomNormalized = normalizeString(nom); // Normalize the input string

      clientesFiltrados.value = clientes.value.filter((cliente) => {
        const clienteNormalized = normalizeString(cliente.NOMBREAPELLIDO); // Normalize the NOMBREAPELLIDO field
        return clienteNormalized.includes(nomNormalized);
      });
    };

    const instance = getCurrentInstance();

    async function eliminarCliente(dni) {
      try {
        console.log("por lo menos entre aca?");
        await api.post("cliente/deleteCliente", {
          dniVet: useStore().dni,
          dni: dni,
        });
        console.log("las refs: ", instance.refs);
        console.log(
          "llegue acaa y la lista es: ",
          instance.refs["losClientes"]
        );
        await loadClientes();

        for (let i = 0; i < instance.refs["losClientes"].length; i++) {
          if (instance.refs["losClientes"]) {
            instance.refs["losClientes"][i].recargarPerros();
          }
        }
      } catch {
        console.error("NO SE PUDO ELIMINAR CLIENTE (mentira)");
      }
    }

    return {
      tab,
      clientes,
      clientesFiltrados,
      mailsClientes,
      mailsVeterinarios,
      dniClientes,
      dniFiltrar,
      nombreFiltrar,
      loadClientes,
      loadVeterinarios,
      registrarCliente,
      filtrarClientes,
      eliminarCliente,
      instance,
      mostrarPopup: ref(false),
      inputRef,
    };
  },
  mounted() {
    checkToken();
    this.loadClientes();
    this.loadVeterinarios();
  },
});
</script>
