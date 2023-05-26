<template>
  <div class="full-width" style="width: max-content">
    <q-card style="width: max-content"  >
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Solicitar turno
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <!-- las opciones deberian ser los perros de cliente -->
          <div class="row no-wrap bg-primary">
            <div class="column">
              <q-select
                v-model="nombreCliente"
                :options="options"
                input-debounce="0"
                use-input
                class="q-px-xl"
                label="Nombre Cliente"
                @filter="filterFn"
              >
                <template v-slot:no-option>
                  <q-item>
                    <q-item-section class="text-grey">
                      No results
                    </q-item-section>
                  </q-item>
                </template>
              </q-select>
              <q-select
                v-if="hayCliente"
                v-model="nombrePerro"
                :options="opcionTamanio"
                class="q-px-xl"
                label="Nombre Perro"
              />
              <q-select
                v-if="hayCliente"
                v-model="nombreServicio"
                :options="opcionServicio"
                class="q-px-xl"
                label="Servicio"
              />
              <q-select
                v-if="esVacuna"
                v-model="vacuna"
                :options="opcion"
                class="q-px-xl"
                label="Vacuna"
              />
            </div>

            <div class="column bg-secondary items-center">
              <q-date v-model="calendario" mask="YYYY-MM-DD" />
            </div> 
          </div>
          <div class="row justify-end q-pt-xl">
            <q-btn
              label="Pedir turno"
              @click="chequearSubmit()"
              color="accent"
            />
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref, computed } from "vue";
import { useStore } from "src/pinia/store";
import { useQuasar } from "quasar";

export default defineComponent({
  name: "formAdopcion",
  setup() {
    const $q = useQuasar();
    const nombreCliente = ref("");
    const nombrePerro = ref("");
    const nombreServicio = ref("");
    const vacuna = ref("");
    const clienteDNI = useStore().dni;

    const getDatosTurno = () => {
      const perro = {
        nombre: nombrePerro.value.value,
        servicio: nombreServicio.value.value,
        vacuna: vacuna.value,
        dnicliente: clienteDNI,
      };
      return perro;
    };

    const onReset = () => {
      console.log("Los datos están mal!");
      nombrePerro.value = "";
      nombreServicio.value = "";
      vacuna.value = "";
      return false;
    };

    // ESTO CAMBIAR POR UNA CONSULTA DE LA DB
    const listaClientes = ["Julia", "Renzo", "Joaco"];
    const options = ref(listaClientes);

    return {
      nombrePerro,
      nombreServicio,
      vacuna,
      clienteDNI,
      opcionServicio: [
        { label: "Consulta", value: "Consulta" },
        { label: "Vacunación", value: "Vacunación" },
        { label: "Desparacitación", value: "Desparacitación" },
        { label: "Castración", value: "Castración" },
      ],
      listaClientes,
      nombreCliente,
      getDatosTurno,
      onReset,
      options,

      filterFn(val, update) {
        if (val === "") {
          update(() => {
            options.value = listaClientes;

            // here you have access to "ref" which
            // is the Vue reference of the QSelect
          });
          return;
        }

        update(() => {
          const needle = val.toLowerCase();
          options.value = listaClientes.filter(
            (v) => v.toLowerCase().indexOf(needle) > -1
          );
        });
      },
    };
  },
  computed: {
    esVacuna() {
      return this.nombreServicio.value === "Vacunación";
    },
    hayCliente() {
      console.log("El nombre servicio ess: ", this.nombreCliente);
      return this.nombreCliente != "" && this.nombreCliente != undefined;
    },
  },
  methods: {
    ejecutarFuncionPadre() {
      const turno = this.getDatosTurno();
      this.$emit("registrarTurno", turno);
    },

    chequearSubmit() {
      /* esto está horrible */

      let nombreValido = this.perroNOMBRE.length > 0;
      let tamanioValido = this.perroTAMANIO.label != undefined;
      let sexoValido = this.perroSEXO.label != undefined;
      let edadValido =
        this.perroEDAD.length > 0 && /^\d+$/.test(this.perroEDAD);
      let telefonoValido =
        /^\d+$/.test(this.perroTELEFONO) &&
        (this.perroTELEFONO.length >= 7 || this.perroTELEFONO.length <= 12);
      let mailValido = this.perroMAIL.includes("@");

      if (
        nombreValido &&
        tamanioValido &&
        edadValido &&
        telefonoValido &&
        sexoValido &&
        mailValido
      ) {
        this.ejecutarFuncionPadre();
      } else {
        this.$q.notify({
          message: "Los datos son incorrectos",
          icon: "warning",
          color: "accent",
          position: "center",
          timeout: "1500",
        });
        this.onReset();
      }
    },
  },
});
</script>

<style scoped>
.q-field__native-wrapper > div > span {
  display: none;
}
</style>
