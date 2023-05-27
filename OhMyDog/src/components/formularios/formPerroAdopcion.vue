<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar perro en adopción
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
            v-model="perroEDAD"
            class="q-px-xl"
            label="Edad aproximada en meses"
            type="text"
          />
          <q-select
            v-model="perroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />

          <q-input
            v-model="perroCOMENTARIO"
            class="q-px-xl"
            label="Comentarios"
            type="text"
          />
          <ul class="q-mx-md q-py-xs">
          <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
            {{ mnsj }}
          </li>
          </ul>
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Registrar Adopción"
              @click="this.ejecutarFuncionPadre();"
              :disabled="!camposValidos"
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
    const perroNOMBRE = ref("");
    const perroMAIL = ref("");
    const perroCOMENTARIO = ref("");
    const perroDNICLIENTE = useStore().dni;

    const getDatosAdopcion = () => {
      const perro = {
        sexo: perroSEXO.value.value,
        tamanio: perroTAMANIO.value.value,
        edad: perroEDAD.value,
        telefono: "0",
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
      perroNOMBRE.value = "";
      perroMAIL.value = "";
      perroCOMENTARIO.value = "";
      return false;
    };

    return {
      perroEDAD,
      perroSEXO,
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
  },
   computed: {
    mensajeError(){
      let sError = [];
      if (!this.nombreValido ){
        sError.push( " El nombre no es correcto" )
      }
      if (!this.tamanioValido ){
        sError.push("Seleccione un tamaño")
      }
      if (!this.sexoValido ){
        sError.push("Seleccione un sexo")
      }
      if (!this.edadValida ){
        sError.push("La edad no es correcta")
      }
      
      return sError
    },
    nombreValido(){
      return this.perroNOMBRE.length > 0 && /^[A-Za-z\s]+$/.test(this.perroNOMBRE);;
    },
    tamanioValido(){
      return this.perroTAMANIO.value != undefined;
    },
    sexoValido(){
      return this.perroSEXO.value != undefined;
    },
    edadValida(){
      return this.perroEDAD.length >= 0 && this.perroEDAD.length < 3 && /^\d+$/.test(this.perroEDAD);
    },
    camposValidos(){
      console.log(this.perroTAMANIO.value)
      return this.nombreValido && this.tamanioValido && this.edadValida && this.sexoValido;
    },
    
  }
});
</script>
