<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md full-width q-mx-xl"
    >
      <q-card-section class="column">
        <div class="column">
          <div class="textoPerfil q-py-sm">
            Fecha del turno: {{ formattedDate }}
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Cliente:</div>
            <div>{{ cliente }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Perro:</div>
            <div>{{ nombrePerro }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Servicio:</div>
            <div>{{ nombreServicio }}</div>
          </div>
        </div>
        <q-card-actions>
          <div class="row justify-end full-width q-pr-sm">
            <q-btn @click="setEstado(id,'Cancelado')" flat v-if="rol > 0 && state == 'Confirmado' " class="q-ml-md">
              <div>Cancelar Turno</div>
            </q-btn>
            <q-btn flat v-if="rol == 2 && state == 'Pendiente'" class="q-ml-md">
              <div>Rechazar</div>
            </q-btn>
            <q-btn
              v-if="rol == 2 && state == 'Pendiente'"
              class="q-ml-md"
              color="accent"
              @click="confirmar = true"
            >
              <div>Confirmar</div>
            </q-btn>
          </div>
        </q-card-actions>
      </q-card-section>
    </q-card>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Confirmar horario</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-select
            v-model="horaTurno"
            :options="opcionHora"
            class="q-px-none"
            label="Bloque horario"
          />
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            color="primary"
            :disable="horaTurno.value == undefined"
            v-close-popup
          />
          <q-btn flat @click="reiniciarHora" label="Cancelar" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaPaseador",
  components: {},
  props: {
    rol: String,
    id: String,
    cliente: String,
    state: String,
    fecha: String,
    nombrePerro: String,
    nombreServicio: String,
  },
  setup() {
    const horaTurno = ref("");
    return {
      confirmar: ref(false),
      horaTurno,
      opcionHora: [
        { label: "Mañana", value: "Mañana" },
        { label: "Tarde", value: "Tarde" },
        { label: "Noche", value: "Noche" },
      ],
    };
  },
  methods: {
    setEstado (id,state) {
      console.log("entre")
      this.$emit("setEstado",{
        id:id,
        state:state,
      })
    },
    reiniciarHora() {
      this.horaTurno = "";
    },
  },
  computed: {
    formattedDate() {
      const date = new Date(this.fecha);
      const options = { year: "numeric", month: "numeric", day: "numeric" };
      return date.toLocaleDateString(undefined, options);
    },
  },
});
</script>
