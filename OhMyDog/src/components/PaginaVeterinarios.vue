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
                    v-for="(veterinario, dni) in veterinariosFiltrados"
                    :key="dni"
                    :dni="veterinario.DNI"
                    :nombreaApellido="veterinario.NOMBREAPELLIDO"
                    :mail="veterinario.MAIL"
                    :telefono="veterinario.TELEFONO"
                  />
                </div>
              </q-tab-panel>
            </q-tab-panels>
          </q-card>
        </q-scroll-area>
      </q-card>

      <q-dialog v-model="mostrarPopup">
        <div class="full-width row items-center bg-white">
          <div class="q-pa-md" style="width: 50rem">
            <div class="textoTituloTarjeta text-accent q-pt-md">
              Agregar Veterinario
            </div>
            <q-form class="q-pa-md" @submit.prevent="registrarVeterinario">
              <q-input
                ref="inputRef"
                class="q-px-xl"
                label="DNI"
                v-model="veterinarioAgregarDni"
                maxlength="8"
                reactive-rules
                hide-bottom-space="true"
                :rules="[
                  (val) => !!val | 'Es necesario completar este campo',
                  (val) => /^\d+$/.test(val) == true,
                ]"
              />
              <q-input
                class="q-px-xl"
                v-model="veterinarioAgregarNombreApellido"
                label="Nombre y Apellido"
                type="text"
                hide-bottom-space="true"
                :rules="[(val) => !!val | 'Es necesario completar este campo']"
              />
              <q-input
                class="q-px-xl"
                v-model="veterinarioAgregarMail"
                label="Correo electrónico"
                type="email"
              />
              <q-input
                class="q-px-xl"
                v-model="veterinarioAgregarTelefono"
                label="Telefono"
                type="tel"
                mask="(###) ### - ####"
              />
              <q-btn
                push
                class="q-mt-lg q-mx-xl"
                color="accent"
                type="submit"
                label="Registrar Veterinario"
              />
            </q-form>
          </div>
        </div>
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
  import { QDialog } from "quasar";

  export default defineComponent({
    name: "PaginaVeterinarios",
    components: {
      TarjetaVeterinario,
      QDialog,
    },
    setup() {
      const inputRef = ref(null);

      const tab = ref("Buscar Veterinario");
      const veterinarios = reactive([]);
      const veterinariosFiltrados = ref([]);
      const dniFiltrar = ref("");
      const veterinarioAgregarDni = ref("")
      const veterinarioAgregarNombreApellido = ref("");
      const veterinarioAgregarMail = ref("");
      const veterinarioAgregarTelefono = ref("");
      const veterinarioAgregarDireccion = ref("");

      const registrarVeterinario = async () => {
        try {
          const response = await api.post("/veterinario/addVeterinario", {
            veterinario: {
              dni: veterinarioAgregarDni.value,
              nombreApellido: veterinarioAgregarNombreApellido.value,
              mail: veterinarioAgregarMail.value,
              telefono: veterinarioAgregarTelefono.value,
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

      async function eliminarVeterinario (dni) {
        try {
          await api.post("veterinario/deleteVeterinario", {
            dni: dni,
            nombre: nombreApellido
          })
          loadVeterinarios();
        } catch {
          console.error('NO SE PUDO ELIMINAR VETERINARIO')
        }
      }

      return {
        tab,
        veterinarios,
        veterinariosFiltrados,
        dniFiltrar,
        veterinarioAgregarDni,
        veterinarioAgregarNombreApellido,
        veterinarioAgregarMail,
        veterinarioAgregarTelefono,
        veterinarioAgregarDireccion,
        loadVeterinarios,
        registrarVeterinario,
        filtrarVeterinario,
        eliminarVeterinario,

        mostrarPopup: ref(false),
        inputRef,
      };
    },
    mounted() {
      checkToken();
      this.loadVeterinarios();
    },
  });
  </script>
