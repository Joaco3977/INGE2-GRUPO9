<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar Historial
        </div>
      </q-card-section>

      <q-card-section class="">
        <div class="text-center q-py-md">
          La entrada solo se podrá editar el mismo día de su creación
        </div>
        <q-form class="q-px-xl" reset>
          <q-select
            v-model="nombreServicio"
            :options="opcionServicio"
            class="q-px-xl"
            label="Servicio"
          />
          <q-select
            v-if="esVacuna"
            v-model="nombreVacuna"
            :options="opcionVacuna"
            class="q-px-xl"
            label="Vacuna"
          />
          <q-input
            class="q-pa-lg"
            v-model="comentario"
            clearable
            filled
            placeholder="Notas"
            type="textarea"
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
          <div class="row justify-end q-pt-xl">
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              :disabled="!camposValidos"
              @click="agregarEntrada()"
              label="Agregar Historial"
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

export default defineComponent({
  name: "formHistorial",
  props: {
    idPerro: String,
  },
  setup(props, { emit }) {
    const nombreServicio = ref("");
    const nombreVacuna = ref("");
    const comentario = ref("");

    const agregarEntrada = async () => {
      let entrada = {
        IDPERRO: props.idPerro,
        DNIVET: useStore().dni,
        NOMBRESERVICIO: nombreServicio.value.value,
        COMENTARIO: comentario.value,
        NOMBREVACUNA: nombreVacuna.value.value,
      };
      emit("registrarEntrada", entrada);
    };

    return {
      nombreServicio,
      nombreVacuna,
      comentario,
      agregarEntrada,
      opcionServicio: [
        { label: "Consulta", value: "Consulta" },
        { label: "Vacunación", value: "Vacunación" },
        { label: "Desparacitación", value: "Desparacitación" },
        { label: "Castración", value: "Castración" },
      ],
      opcionVacuna: [
        { label: "Rabia", value: "Rabia" },
        { label: "Parvovirus canino", value: "Parvovirus canino" },
        { label: "Moquillo", value: "Moquillo" },
        { label: "Hepatitis canina", value: "Hepatitis canina" },
      ],
    };
  },
  methods: {},
  computed: {
    esVacuna() {
      return this.nombreServicio.value === "Vacunación";
    },
    camposValidos() {
      return this.nombreServicio !== null;
    },
  },
});
</script>
