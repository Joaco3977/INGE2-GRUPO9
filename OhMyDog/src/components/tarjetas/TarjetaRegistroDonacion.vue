<template>
  <div class="bg-white" style="width: 70vw; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"
    >
      <q-card-section
        class="bg-primary textoNoItems text-white"
      >
        {{ estado }}
      </q-card-section>
      <q-card-section class="column">
        <div class="column">
          <div class="textoFecha q-py-sm">
            Fecha: {{ formattedDate }}
          </div>
          <div class="textoDescripcion q-pr-sm q-pb-xs">
              Nombre de la campaña: {{ nombre }}
          </div>
          <div v-if="dniCliente !== null" class="textoDescripcion q-pr-sm q-pb-xs">
            DNI del cliente: {{ dniCliente }}
          </div>
          <div v-if="dniCliente === null" class="textoDescripcion q-pr-sm q-pb-xs">
            Donacion anonima
          </div>
          <div class="textoDescripcion q-pr-sm q-pb-xs">
            Cantidad: {{ cantidad }}$ pesos argentinos
          </div>
        </div>
      </q-card-section>
    <q-card-actions>
      <q-btn
          v-if="estado !== 'TRANSFERIDO'"
          @click="marcarTransferido(id)"
          color="accent"
          class=""
          style="width: max-content; height: max-content"
        >
          Marcar como transferido
        </q-btn>
    </q-card-actions>
  </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { api } from "src/boot/axios";

export default defineComponent({
  name: "TarjetaRegistrosDonacion",
  components: {},
  props: {
    id: String,
    fecha: String,
    estado: String,
    nombre: String,
    dniCliente: String,
    cantidad: String,
  },
  setup() {
    return {}
  },
  methods: {
    marcarTransferido (id) {
      api.post('/donacion/marcarTransferido', {
        id: id
      })
      .then(() => {
        this.$emit('loadRegistrosDonacion')
      })
      .catch((error) => {
        console.log(error)
      })
    }
  },
  computed: {
    formattedDate() {
      const date = new Date(this.fecha);
      const options = { year: "numeric", month: "numeric", day: "numeric" };
      return date.toLocaleDateString(undefined, options);
    }
  },
});
</script>
