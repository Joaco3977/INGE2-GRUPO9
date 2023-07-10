<template>
  <div class="bg-primary" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-white text-white q-my-md"
      style="width: 35vw"
    >
      <!-- style="min-width: 20rem; max-width: 25rem" -->
      <q-card-section class="row justify-end">
        <q-btn
          v-if="rol == 2" 
          @click="mostrarPopupEditar = true"
          color="accent"
          class=""
          style="width: max-content; height: max-content"
        >
          <div>Editar</div>
        </q-btn>
      </q-card-section>
      <q-card-section>
        <!-- Contenido -->
        <div class="row no-wrap">
          <div class="column col-12 justify-start q-pl-sm">
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs">
                Fecha:
              </div>
              <div class="text-primary q-pl-md q-pb-md">
                {{ formattedDate }}
              </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs">
                Veterinario:
              </div>
              <div class="text-primary q-pl-md q-pb-md">
                DNI:{{ veterinario.DNI }} - Nombre:{{
                  veterinario.NOMBREAPELLIDO
                }}
              </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs">
                Servicio:
              </div>
              <div class="text-primary q-pl-md q-pb-md">
                {{ formattedService }}
              </div>
            </div>
            <div class="row items-baseline q-pb-sm">
              <div class="textoTituloPosteo text-primary q-mr-md q-pb-xs">
                Comentario:
              </div>
              <div class="text-primary q-pl-md q-pb-md">{{ comentario }}</div>
            </div>
            <q-dialog v-model="mostrarPopupEditar">
              <formHistorial
                @editarHistorial="editarHistorial"
                :id="id"
                :fecha="fecha"
                :Aservicio="servicio"
                :Acomentario="comentario"
                :AnombreVacuna="nombreVacuna"
              />
            </q-dialog>
          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { useStore } from "../../pinia/store.js";
import { api } from "src/boot/axios";
import { defineComponent, ref } from "vue";
import formHistorial from "../formulariosEditar/formHistorial.vue";

export default defineComponent({
  name: "TarjetaDonacion",
  components: {
    formHistorial,
  },
  props: {
    id: String,
    fecha: String,
    servicio: String,
    comentario: String,
    nombreVacuna: String,
    dniVet: String,
  },
  setup(props, { emit }) {
    const rol = useStore().rol;
    const veterinario = ref({});
    const mostrarPopupEditar = ref(false);
    const getDatosVeterinario = async () => {
      await api
        .post("/veterinario/getVeterinarioHistorial", {
          dni: parseInt(props.dniVet),
        })
        .then((response) => {
          veterinario.value = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    };

    const editarHistorial = async (entrada) => {
      await api

        .post("/historial/editarHistorial", {
          entrada: entrada,
        })
        .then(() => {
          emit("loadHistorial");
        })
        .catch((error) => {
          console.log(error);
        });
      mostrarPopupEditar.value = false;
    };
    return {
      rol,
      getDatosVeterinario,
      editarHistorial,
      veterinario,
      mostrarPopupEditar,
    };
  },
  methods: {
  },
  mounted() {
    this.getDatosVeterinario();
  },
  computed: {
    formattedService() {
      let formattedService = this.servicio;
      if (this.servicio === "Vacunación") {
        formattedService += ` - ${this.nombreVacuna}`;
      }
      return formattedService;
    },
    formattedDate() {
      const date = new Date(this.fecha);
      let hora = date.getHours();
      if (hora < 10) {
        hora = `0${hora}`;
      }
      let minuto = date.getMinutes();
      if (minuto < 10) {
        minuto = `0${minuto}`;
      }
      let formattedDate = `${date.toLocaleDateString()}`;
      return formattedDate;
    },
  },
});
</script>
