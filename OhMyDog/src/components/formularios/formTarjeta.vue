<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Pagar con Tarjeta
        </div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <div class="text-center q-py-sm">
          Usted donará ${{ cantidad }} pesos argentinos
        </div>
        <q-form class="q-gutter-md">
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
            maxlength="19"
            mask="####-####-####-####"
            v-model="numero"
            label="Número de la tarjeta"
          />

          <q-input
            class="q-px-lg"
            filled
            type="text"
            mask="##/####"
            maxlength="7"
            v-model="vencimiento"
            label="Fecha de vencimiento"
          />

          <q-input
            class="q-px-lg"
            filled
            v-model="codigo"
            maxlength="3"
            label="Código de seguridad"
          />

          <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>

          <div class="row justify-end">
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              label="Realizar Donación"
              @click="realizarDonacion(link, cantidad)"
              :disabled="!camposValidos"
              color="accent"
            />

          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { api } from "../../boot/axios.js";
import { useStore } from "src/pinia/store";

export default defineComponent({
  name: "formTarjeta",
  components: {},
  props: {
    cantidad: Number,
  },
  setup(props) {
    const nombreTitular = ref("");
    const numero = ref("");
    const codigo = ref("");
    const vencimiento = ref("");

    const sumarBonus = async () => {
      const bonus = props.cantidad * 0.1;
      await api
        .post("/donacion/sumarBonus", {
          dni: useStore().dni,
          bonus: bonus,
        })
        .then(() => {})
        .catch((error) => {
          console.log(error);
        });
    };

    return {
      nombreTitular,
      numero,
      codigo,
      vencimiento,
      sumarBonus,
    };
  },
  methods: {
    realizarDonacion(link, cantidad) {
      let tarjeta = {
        titular: this.nombreTitular,
        numero: this.numero,
        codigo: this.codigo,
        vencimiento: this.vencimiento,
      }
      let data = {
        tarjeta: tarjeta,
        cantidad: cantidad
      }
      this.$emit('pagarConTarjeta', data)
    },
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreTitularValido) {
        sError.push("Complete el nombre del titular");
      }
      if (!this.numeroValido) {
        sError.push("Complete el número de tarjeta");
      }
      if (!this.vencimientoValido) {
        sError.push("Complete la fecha de vencimiento");
      }
      if (this.tarjetaVencida) {
        sError.push("La tarjeta esta vencida");
      }
      if (!this.codigoValido) {
        sError.push("Complete el codigo de seguridad");
      }
      return sError;
    },

    nombreTitularValido() {
      return (
        this.nombreTitular.length > 0 &&
        /^[A-Za-zÀ-ÿ\s]+$/.test(this.nombreTitular)
      );
    },

    tarjetaVencida() {
      let anioActual = (new Date()).getFullYear()
      let mesActual = (new Date()).getMonth() + 1;
      let anioTarjeta = parseInt(this.vencimiento.split('/')[1])
      let mesTarjeta = parseInt(this.vencimiento.split('/')[0])
      if (anioTarjeta < anioActual) {
        return true
      } else if (anioActual === anioTarjeta) {
        return mesTarjeta <= mesActual
      } else {
        return false
      }
    },

    numeroValido() {
      let numeroAux = this.numero.replaceAll('-', '');
      return numeroAux.length === 16 && /^\d+$/.test(numeroAux);
    },

    vencimientoValido() {
      return this.vencimiento.length === 7;
    },

    codigoValido() {
      return this.codigo.length == 3 && /^\d+$/.test(this.codigo);
    },
    camposValidos() {
      return (
        this.nombreTitularValido &&
        this.numeroValido &&
        this.vencimientoValido &&
        this.codigoValido &&
        !this.tarjetaVencida
      );
    },
  },
});
</script>
