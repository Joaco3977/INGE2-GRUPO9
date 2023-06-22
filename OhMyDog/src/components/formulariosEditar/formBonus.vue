<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Editar monto bonificacion
        </div>
      </q-card-section>

      <q-card-section class="q-pt-md">
        <div class="text-center q-py-sm">
          Actualmente el cliente tiene ${{ montoBonificacion }} pesos argentinos a favor
        </div>
        <q-form class="q-gutter-md">
          <q-input
            class="q-px-lg"
            filled
            mask="######"
            maxlength="7"
            v-model="nuevoMonto"
            label="Nuevo monto"
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
              @click="cambiarMontoBonus(nuevoMonto)"
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

export default defineComponent({
  name: "formBonus",
  components: {},
  props: {
    montoBonificacion: String,
    dniCliente: String,
  },
  setup(props, { emit }) {
    const nuevoMonto = ref('')

    const cambiarMontoBonus = async () => {
      await api.post('/donacion/sumarBonus', {
        dni: props.dniCliente,
        bonus: parseInt(nuevoMonto.value),
      })
      .then(() => {
        emit('loadClientes', {})
      })
      .catch((error) => {
        console.log(error)
      })
    }


    return {
      nuevoMonto,
      cambiarMontoBonus
    };
  },
  methods: {
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.montoValido) {
        sError.push("El monto ingreso no es valido");
      }
      return sError;
    },

    montoValido() {
      return this.nuevoMonto >= 0 && /^\d+$/.test(this.nuevoMonto);
    },

    camposValidos() {
      return (
        this.montoValido
      );
    },

  },
});
</script>
