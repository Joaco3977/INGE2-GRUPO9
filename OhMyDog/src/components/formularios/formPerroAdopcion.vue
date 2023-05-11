<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold" >Agregar perro en adopción</div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <div class="text-h6 q-pb-xs text-center text-primary"> Información básica </div>
        <q-form class="q-pa-xl" @submit.prevent="ejecutarFuncionPadre" reset>
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
            v-model="perroEDAD"
            class="q-px-xl"
            label="Edad Aproximada"
            type="text"
          />
          <q-select
            v-model="perroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />
          <q-input
            v-model="perroTELEFONO"
            class="q-px-xl"
            label="Telefono"
            type="number"
          />
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
          <div class="row justify-end">
            <q-btn label="Registrar Adopcion" type="submit" color="accent" />
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

export default defineComponent({
  name: "formAdopcion",
  setup() {

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
        tamanio:perroTAMANIO.value.value,
        edad: perroEDAD.value,
        telefono: perroTELEFONO.value,
        nombre:perroNOMBRE.value,
        mail:perroMAIL.value,
        comentario:perroCOMENTARIO.value,
        dnicliente:perroDNICLIENTE,
      }
      return perro
    }

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
    };
  },
  methods: {
    ejecutarFuncionPadre() {
      const perro = this.getDatosAdopcion();
      this.$emit('registrarPerro',perro);
    }
  },
});
</script>
