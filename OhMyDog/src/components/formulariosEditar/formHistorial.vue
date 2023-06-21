<template>
    <div class="flex">
      <q-card style="width: 40rem">
        <q-card-section class="bg-secondary">
          <div class="text-h5 text-uppercase text-white text-center text-bold">
            Editar Historial
          </div>
        </q-card-section>
  
        <q-card-section class="">
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
              <q-btn :disabled="!camposValidos" @click="editarEntrada()" label="Editar Historial" color="accent" v-close-popup />
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
      id:String,
      Aservicio:String,
      Acomentario:String,
      AnombreVacuna:String,
    },
    setup(props, { emit }) {

      const nombreServicio = ref (props.Aservicio)
      const nombreVacuna = ref (props.AnombreVacuna)
      const comentario = ref (props.Acomentario)
  
      const editarEntrada = async () => {
        let entrada = {
          ID:props.id,
          NOMBRESERVICIO: nombreServicio.value.value,
          COMENTARIO: comentario.value,
          NOMBREVACUNA: nombreVacuna.value.value,
        }
        emit('editarHistorial', entrada);
      }
  
      return {
        nombreServicio,
        nombreVacuna,
        comentario,
        editarEntrada,
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
      }
    },
    methods: {
  
    },
    computed: {
      esVacuna() {
        return this.nombreServicio.value === "Vacunación";
      },
      camposValidos () {
        return this.nombreServicio !== null
      }
    },
  });
  </script>