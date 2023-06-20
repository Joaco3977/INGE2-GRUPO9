<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Editar perro en adopción
        </div>
      </q-card-section>

      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <q-input
            v-if="!mostrarInput"
            v-model="perroNOMBRE"
            class="q-px-xl"
            label="Nombre"
            type="text"
          />
          <q-checkbox class="q-px-xl" v-model="mostrarInput">No tiene Nombre</q-checkbox>
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
            type="number"
          />
          <q-input
            v-model="perroMAIL"
            class="q-px-xl"
            label="Mail de contacto"
            type="email"
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
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              label="Editar Adopción"
              @click="this.ejecutarFuncionPadre();"
              :disabled="!camposValidos"
              color="accent"
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
  props:{
    nombre: String,
    edad: String,
    tamanio: String,
    sexo: String,
    telefono: String,
    mail: String,
    comentario: String,
  },
  setup(props) {
    const $q = useQuasar()
    const perroSEXO = ref(props.sexo);
    const perroTAMANIO = ref(props.tamanio);
    const perroEDAD = ref(props.edad);
    const perroNOMBRE = ref(props.nombre);
    const perroMAIL = ref(props.mail);
    const perroCOMENTARIO = ref(props.comentario);
    const mostrarInput=ref(false)
    if(perroNOMBRE.value == ""){
      mostrarInput.value=true
    }
    const getDatosAdopcion = () => {
      const perro = {
        sexo: perroSEXO.value.value,
        tamanio: perroTAMANIO.value.value,
        edad: perroEDAD.value,
        telefono: "0",
        nombre: perroNOMBRE.value,
        mail: perroMAIL.value,
        comentario: perroCOMENTARIO.value,
      };
      if(mostrarInput.value){
        perro.nombre="";
      }
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
      mostrarInput,
      perroEDAD,
      perroSEXO,
      perroNOMBRE,
      perroMAIL,
      perroCOMENTARIO,
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
      this.$emit("editarPerro", perro);
    },
  },
   computed: {
    mensajeError(){
      let sError = [];
      if (!this.nombreValido ){
        sError.push( "Ingrese un nombre válido" )
      }
      if (!this.tamanioValido ){
        sError.push("Seleccione un tamaño")
      }
      if (!this.sexoValido ){
        sError.push("Seleccione un sexo")
      }
      if (!this.edadValida ){
        sError.push("Ingrese una edad válida")
      }
      if (!this.mailValido){
        sError.push("Ingrese un mail válido")
      }
      return sError
    },
    nombreValido(){
      return this.perroNOMBRE.length == 0 || /^[A-Za-zÀ-ÿ\s]+$/.test(this.perroNOMBRE);;
    },
    tamanioValido(){
      return toString(this.perroTAMANIO.value) != undefined;
    },
    mailValido() {
      return (
        this.perroMAIL.length > 5 &&
        this.perroMAIL.includes("@") &&
        this.perroMAIL.includes(".")
      );
    },
    sexoValido(){
      return toString(this.perroSEXO.value) != undefined;
    },
    edadValida(){
      return this.perroEDAD.length >= 0 && this.perroEDAD.length < 3 && /^\d+$/.test(this.perroEDAD) && this.perroEDAD > 0;
    },
    camposValidos(){
      return this.nombreValido && this.tamanioValido && this.edadValida && this.sexoValido && this.mailValido;
    },

  }
});
</script>
