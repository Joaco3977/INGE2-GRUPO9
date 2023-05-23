<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar perro
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <q-input
            v-model="perroNOMBRE"
            class="q-px-xl"
            label="Nombre"
            type="text"
          />
          <q-select
            v-model="perroTAMANIO"
            :options="opcionTamanio"
            class="q-px-xl"
            label="Tamaño"
          />
          <q-input
            v-model="perroCOLOR"
            class="q-px-xl"
            label="Color"
            type="text"
          />
          <q-input
            v-model="perroNACIMIENTO"
            class="q-px-xl"
            label="Fecha de nacimiento"
            type="text"
          />
          <q-select
            v-model="perroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />
          <q-input v-model="perroTELEFONO" class="q-px-xl" label="Teléfono celular" />
          <q-input
            v-model="perroMAIL"
            class="q-px-xl"
            label="Mail"
            type="email"
          />
          <q-input
            v-model="perroCOMENTARIO"
            class="q-px-xl"
            label="Comentarios"
            type="text"
          />
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Registrar Adopción"
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

    const perroSEXO = ref("");
    const perroTAMANIO = ref("");
    const perroEDAD = ref("");
    const perroTELEFONO = ref("");
    const perroNOMBRE = ref("");
    const perroMAIL = ref("");
    const perroCOMENTARIO = ref("");
    const perroDNICLIENTE = useStore().dni;

    const getDatosAdopcion = () => {
      const perro = {
        sexo: perroSEXO.value.value,
        tamanio: perroTAMANIO.value.value,
        edad: perroEDAD.value,
        telefono: perroTELEFONO.value,
        nombre: perroNOMBRE.value,
        mail: perroMAIL.value,
        comentario: perroCOMENTARIO.value,
        dnicliente: perroDNICLIENTE,
      };
      return perro;
    };

    const onReset = () => {
      console.log("Los datos están mal!");
      perroSEXO.value = "";
      perroTAMANIO.value = "";
      perroEDAD.value = "";
      perroTELEFONO.value = "";
      perroNOMBRE.value = "";
      perroMAIL.value = "";
      perroCOMENTARIO.value = "";
      return false;
    };

    return {
      perroEDAD,
      perroSEXO,
      perroTELEFONO,
      perroNOMBRE,
      perroMAIL,
      perroCOMENTARIO,
      perroDNICLIENTE,
      opcionSexo: [
        { label: "Macho", value: "Macho" },
        { label: "Hembra", value: "Hembra" },
      ],
      perroTAMANIO,
      opcionTamanio: [
        { label: "Pequeño", value: "Pequeño" },
        { label: "Mediano", value: "Mediano" },
        { label: "Grande", value: "Grande" },
      ],
      getDatosAdopcion,
      onReset,
    };
  },
  methods: {
    ejecutarFuncionPadre() {
      const perro = this.getDatosAdopcion();
      this.$emit("registrarPerro", perro);
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
