<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Pedir turno
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <!-- las opciones deberian ser los perros de cliente -->
          <q-select
            v-model="nombrePerro"
            :options="opcionTamanio"
            class="q-px-xl"
            label="Perro"
          />
          <q-select
            v-model="nombreServicio"
            :options="opcionServicio"
            class="q-px-xl"
            label="Servicio"
          />
          <q-select  v-if="esVacuna"
            v-model="vacuna"
            :options="opcion"
            class="q-px-xl"
            label="Vacuna"
          />
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
import { defineComponent, ref } from "vue";
import { useStore } from "src/pinia/store";
import { useQuasar } from 'quasar'

export default defineComponent({
  name: "formAdopcion",
  setup() {
    const $q = useQuasar()

    const nombrePerro = ref("");
    const nombreServicio = ref("");
    const vacuna = ref("");
    const clienteDNI = useStore().dni;

    const getDatosTurno = () => {
      const perro = {
        nombre: nombrePerro.value.value,
        servicio: nombreServicio.value.value,
        vacuna: vacuna.value,
        nombre: perroNOMBRE.value,
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
      opcionTamanio: [
        { label: "Pequeño", value: "Pequeño" },
        { label: "Mediano", value: "Mediano" },
        { label: "Grande", value: "Grande" },
      ],
      getDatosTurno,
      onReset,
    };
  },
  computed:{
    esVacuna(){
      console.log("El nombre servicio ess: ", this.nombreServicio.value)
      return this.nombreServicio.value === "Vacunación"
    }
  },
  methods: {
    ejecutarFuncionPadre() {
      const turno = this.getDatosTurno();
      this.$emit("registrarTurno", turno);
    },

    chequearSubmit() {
      /* esto está horrible */

      let nombreValido = this.perroNOMBRE.length > 0;
      let tamanioValido = this.perroTAMANIO.label != undefined
      let sexoValido = this.perroSEXO.label != undefined
      let edadValido = this.perroEDAD.length > 0 && /^\d+$/.test(this.perroEDAD) ;
      let telefonoValido = /^\d+$/.test(this.perroTELEFONO) && 
        ( this.perroTELEFONO.length >=  7 ||
          this.perroTELEFONO.length <= 12 )
      let mailValido = this.perroMAIL.includes("@")
      
      if ( nombreValido && tamanioValido && edadValido && telefonoValido && sexoValido && mailValido) { 
        this.ejecutarFuncionPadre();
      } else {

        this.$q.notify({
          message: 'Los datos son incorrectos',
          icon: 'warning',
          color: 'accent',
          position: 'center',
          timeout:'1500',
        });
        this.onReset();
      }
    },
  },
});
</script>
