<template>
  <div class="bg-white" style="width: full; max-height: 100vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        VETERINARIOS
      </div>

      <q-btn
        color="accent"
        @click="mostrarPopup = true"
        class="q-ma-md self-end"
        style="width: fit-content"
      >
        <div class="textoBoton">Agregar Veterinario</div>
      </q-btn>
    </div>
    <q-card flat class="column">
      <q-scroll-area
        :thumb-style="thumbStyle"
        :bar-style="barStyle"
        style="height: 84vh"
        class="bg-white"
      >
        <q-card flat>
          <q-separator />

          <q-tab-panels v-model="tab" animated>
            <q-tab-panel name="Buscar Veterinario">
              <div class="full-width row items-center">
                <q-search
                  v-model="dniFiltrar"
                  placeholder="Buscar Veterinario por DNI"
                ></q-search>
                <TarjetaVeterinario
                  @ejecutarFuncion="eliminarVeterinario"
                  @loadVeterinarios="loadVeterinarios"
                  v-for="(veterinario, dni) in veterinariosFiltrados"
                  :key="dni"
                  :dni="veterinario.DNI"
                  :nombreApellido="veterinario.NOMBREAPELLIDO"
                  :mail="veterinario.MAIL"
                  :telefono="veterinario.TELEFONO"
                  :mailsClientes="mailsClientes"
                  :mailsVeterinarios="mailsVeterinarios"
                  :dniClientes="dniClientes"
                  :dniVeterinarios="dniVeterinarios"
                />
              </div>
            </q-tab-panel>
          </q-tab-panels>
        </q-card>
      </q-scroll-area>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <FormVeterinario
        @registrarVeterinario="registrarVeterinario"
        :mailsClientes="mailsClientes"
        :mailsVeterinarios="mailsVeterinarios"
        :dniClientes="dniClientes"
        :dniVeterinarios="dniVeterinarios"
      />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";
import { api } from "../boot/axios.js";
import { useStore } from "../pinia/store.js";
import { LocalStorage } from "quasar";
import TarjetaVeterinario from "./tarjetas/TarjetaVeterinario.vue";
import { checkToken } from "../functions/check.js";
import FormVeterinario from "./formularios/formVeterinario.vue";
import { normalizeString } from "src/functions/misc";

export default defineComponent({
  name: "PaginaVeterinarios",
  components: {
    TarjetaVeterinario,
    FormVeterinario,
  },
  setup() {
    const inputRef = ref(null);

    const tab = ref("Buscar Veterinario");
    const veterinarios = reactive([]);
    const veterinariosFiltrados = ref([]);
    const dniFiltrar = ref("");
    const veterinarioAgregarDni = ref("");
    const veterinarioAgregarNombreApellido = ref("");
    const veterinarioAgregarMail = ref("");
    const veterinarioAgregarTelefono = ref("");
    const veterinarioAgregarDireccion = ref("");

    const mailsClientes = ref([]);
    const mailsVeterinarios = ref([]);
    const dniClientes = ref([]);
    const dniVeterinarios = ref([]);

    const registrarVeterinario = async (veterinario) => {
      try {
        const response = await api.post("/veterinario/addVeterinario", {
          veterinario: {
            dni: veterinario.value,
            nombreApellido: veterinario.value,
            mail: veterinario.value,
            telefono: veterinario.value,
          },
        });
        loadVeterinarios();
      } catch (error) {
        console.error(error);
      }
    };

    const loadVeterinarios = async () => {
      try {
        const response = await api.get("/veterinario/getVeterinarios");
        if (response !== false) {
          veterinarios.value = response.data;
          veterinariosFiltrados.value = response.data;
          mailsVeterinarios.value = response.data.map((vet) =>
            normalizeString(vet.MAIL)
          );
          dniVeterinarios.value = response.data.map((vet) =>
            vet.DNI
          );
          console.log(dniVeterinarios.value)
        }
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
          mailsClientes.value = response.data.map((cliente) =>
            normalizeString(cliente.MAIL)
          );
          dniClientes.value = response.data.map((cliente) => cliente.DNI);
        }
      } catch (error) {
        console.error(error);
      }
    };

    watch(dniFiltrar, (nuevoValor, valorAnterior) => {
      this.filtrarVeterinario(nuevoValor, veterinarios);
    });

    const filtrarVeterinario = () => {
      const query = dniFiltrar.value;
      veterinariosFiltrados.value = veterinario.value.filter((veterinario) =>
        veterinario.dni.includes(query)
      );
    };

    async function eliminarVeterinario(dni) {
      try {
        await api.post("veterinario/deleteVeterinario", {
          dni: dni,
          nombre: nombreApellido,
        });
        loadVeterinarios();
      } catch {
        console.error("NO SE PUDO ELIMINAR VETERINARIO");
      }
    }

    return {
      tab,
      veterinarios,
      veterinariosFiltrados,
      dniFiltrar,
      loadVeterinarios,
      registrarVeterinario,
      filtrarVeterinario,
      eliminarVeterinario,
      mailsClientes,
      mailsVeterinarios,
      dniVeterinarios,
      dniClientes,
      loadClientes,
      mostrarPopup: ref(false),
      inputRef,
    };
  },
  mounted() {
    checkToken();
    this.loadVeterinarios();
    this.loadClientes();
  },
});
</script>
