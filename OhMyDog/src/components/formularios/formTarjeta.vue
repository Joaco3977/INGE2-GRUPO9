<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold" >Pagar con Tarjeta</div>
      </q-card-section>
      
      <q-card-section class="q-pt-md">
        <div class="text-center q-py-sm"> Usted donará ${{ cantidad }} pesos argentinos </div> 
        <q-form  class="q-gutter-md">
          <q-input
            class="q-px-lg"
            filled
            type="text"
            v-model="nombreTitular"
            label="Nombre del titular"
          />

          <q-input
            class="q-px-lg"
            filled
            type="number"
            v-model="numero"
            label="Numero"
          />

          <q-input
            class="q-px-lg"
            filled
            type="text"
            v-model="vencimiento"
            label="Fecha de vencimiento"
          />

          <q-input
            class="q-px-lg"
            filled
            type="number"
            v-model="codigo"
            label="Codigo de seguridad"
          />

          <ul class="q-mx-md q-py-xs">
          <li v-for="mnsj in mensajeError" :key="mnsj" class="bg-white text-accent text-bold">
            {{ mnsj }}
          </li>
          </ul>

          <div class="row justify-end">
            <q-btn label="Realizar Donacion"  @click="realizarDonacion(link, cantidad)" :disabled="!camposValidos"  color="accent" v-close-popup />
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
import { api } from '../../boot/axios.js'
import { useStore } from "src/pinia/store";

export default defineComponent({
  name: "formTarjeta",
  components: {},
  props: {
    link: String,
    cantidad: Number,
  },
  setup(props) {
    const nombreTitular = ref('')
    const numero = ref('')
    const codigo = ref('')
    const vencimiento = ref('')

    const realizarDonacion = async (link, cantidad) => {
      console.log('DONACION')
      console.log('Link: ', link)
      console.log('Cantidad: ', cantidad , '$')
    }

    const sumarBonus = async () => {
      const bonus = props.cantidad * 0.1;
      await api.post('/donacion/sumarBonus', {
        dni: useStore().dni,
        bonus: bonus,
      })
      .then(() => {

      })
      .catch((error) => {
        console.log(error);
      })
    }

    return {
      nombreTitular,
      numero,
      codigo,
      vencimiento,
      sumarBonus,
      realizarDonacion,
    };
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreTitularValido) {
        sError.push("Complete el nombre del titular");
      }
      if (!this.numeroValido){
        sError.push("Complete el número de tarjeta")
      }
      if (!this.vencimientoValido){
        sError.push("Complete la fecha de vencimiento")
      }
      if (!this.codigoValido){
        sError.push("Complete el codigo de seguridad")
      }
      return sError;
    },

    nombreTitularValido(){
      return this.nombreTitular.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.nombreTitular);
    },

    numeroValido(){
      return this.numero.length >= 16 && /^\d+$/.test(this.numero);
    },

    vencimientoValido(){
      return this.vencimiento.length > 0 
    },

    codigoValido(){
      return this.codigo.length == 3 && /^\d+$/.test(this.codigo);
    },
    camposValidos() {
      return (
        this.nombreTitularValido
        &&
        this.numeroValido
        &&
        this.vencimientoValido
        &&
        this.codigoValido
      );
    },
  },
},
);
</script>
