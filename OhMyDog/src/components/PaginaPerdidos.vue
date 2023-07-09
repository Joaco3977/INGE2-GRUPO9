<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->

  <div class="bg-white full-height full-width" style="height: 97vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        PERROS PERDIDOS
      </div>
      <q-btn
        v-if="rol > 0"
        @click="mostrarPopupM"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton" s>Agregar perro perdido</div>
      </q-btn>
    </div>

    <q-card stretch flat class="bg-white full-width full-height column no-wrap">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md full-width"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <!-- EN ESTA ETIQUETA VA @click="loadPerros" y a su vez tambien va en el mounted para que cargue de entrada todos los perros disponible ( faltaria agregar un label que informe cuando no hya perros (vectordedatos vuelve vacio de db))-->
        <q-tab
          @click="loadPerros"
          name="perrosOtros"
          label="Perros perdidos"
        />
        <q-tab
          @click="loadPerrosPropios"
          v-if="rol === 1"
          name="perrosPropios"
          label="Mis perros perdidos"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated class="full-width">
        <q-tab-panel name="perrosOtros">
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 75vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify">
              <TarjetaPerdido
                @eliminarPerroAdopcion="eliminarPerroAdopcion"
                @marcarAdoptado="marcarAdoptado"
                @editarPerro="editarPerro"
                v-for="perro of perrosDatos"
                :key="perro.IDPERROPERDIDO"
                :id="perro.IDPERROPERDIDO"
                :rol="rol"
                :dnicliente="perro.DNICLIENTE"
                :servicio="servicio1"
                :nombre="perro.NOMBRE"
                :sexo="perro.SEXO"
                :fecha="perro.FECHAPERDIDA"
                :zona="perro.ZONA"
                :telefono="perro.TELEFONO"
                :comentario="perro.COMENTARIO"
                :encontrado="perro.ENCONTRADO"
              />
            </div>
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="perrosDatos.length === 0"
            >
              ¡No hay ningún perro perdido!
            </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="perrosPropios" class="column">
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 75vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify">
              <TarjetaPerdido
                @eliminarPerroAdopcion="eliminarPerroAdopcion"
                @marcarAdoptado="marcarAdoptado"
                @editarPerro="editarPerro"
                v-for="perro of perrosDatos"
                :key="perro.IDPERROPERDIDO"
                :id="perro.IDPERROPERDIDO"
                :rol="rol"
                :dnicliente="perro.DNICLIENTE"
                :servicio="servicio2"
                :nombre="perro.NOMBRE"
                :edad="perro.EDAD"
                :tamanio="perro.TAMANIO"
                :fecha="perro.FECHAPERDIDA"
                :zona="perro.ZONA"
                :sexo="perro.SEXO"
                :telefono="perro.TELEFONO"
                :mail="perro.MAIL"
                :comentario="perro.COMENTARIO"
                :encontrado="perro.ENCONTRADO"
              />
            </div>
            <div
              class="row textoNoItems justify-center full-height content-center q-pa-xl"
              v-if="perrosDatos.length === 0"
            >
              ¡No tenés ningún perro perdido!
            </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <formPerdido @registrarPerro="registrarPerro"
      />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref, reactive } from "vue";
import { QDialog } from "quasar";
import TarjetaPerdido from "./tarjetas/TarjetaPerdido.vue";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";
import formPerdido from "./formularios/formPerroPerdido.vue";

export default defineComponent({
  name: "PaginaPerdido",
  components: {
    TarjetaPerdido,
    QDialog,
    formPerdido,
  },
  setup() {
    const perrosDatos = ref([]);
    const mostrarPopup = ref("false");
    const rol = useStore().rol;
    const tab = ref("perrosOtros");
    const servicio1 = "perrosOtros";
    const servicio2 = "perrosMios";

    const loadPerros = async () => {
      try {
        const response = await api.get("/perroPerdido/getPerrosPerdidos");
        perrosDatos.value = response.data;
      } catch (error) {
        console.error(error);
      }
    };
    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }
    const registrarPerro = async (perro) => {
      console.log(perro)
      try {
        await api.post("/perroPerdido/addPerroPerdido", {
          perro,
          rol: useStore().rol,
          dni: useStore().dni,
          nombre: useStore().nombre,
        });
        mostrarPopupM();
        if (tab.value === "perrosOtros") {
          loadPerros();
        } else {
          loadPerrosPropios();
        }
      } catch (error) {
        console.error(error);
      }
    };

    const editarPerro = async (perro) => {
      try {
        const response = await api.post("/perroPerdido/editarPerro",{
          perro,
          quienSoy: quienSoy,
        })
        if (tab.value === "perrosOtros") {
          loadPerros();
        } else {
          loadPerrosPropios();
        }
      } catch (error) {
        console.error(error);
      }}

    async function eliminarPerroAdopcion(data) {
      try {
        await api.post("perroPerdido/deletePerroPerdido", {
          rol: useStore().rol,
          dni: useStore().dni,
          nombre: useStore().nombre,
          dnicliente: data.dnicliente,
          nombre: data.nombre,
        });
        if (tab.value === "perrosOtros") {
          loadPerros();
        } else {
          loadPerrosPropios();
        }
      } catch {
        console.error("No es posible eliminar al perro perdido");
      }
    }

    const marcarAdoptado = async (id) => {
      await api.post('perroPerdido/marcarEncontrado', {
        id: id
      })
      .then(() => {
        if (tab.value === "perrosOtros") {
          loadPerros();
        } else {
          loadPerrosPropios();
        }
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const loadPerrosPropios = async () => {
      try {
        const response = await api.post(
          "/perroPerdido/getPerrosPerdidosPropios",
          { dni: useStore().dni }
        );
        perrosDatos.value = response.data;
      } catch (error) {
        console.error(error);
      }
    };

    const mostrarPopupM = () => {
      mostrarPopup.value = !mostrarPopup.value;
    };

    return {
      tab,
      store: useStore(),
      servicioActual: "adopciones",
      misAdopciones: "misPerros",
      registrarPerro,
      editarPerro,
      perrosDatos,
      loadPerros,
      loadPerrosPropios,
      mostrarPopupM,
      mostrarPopup,
      rol,
      servicio1,
      servicio2,
      eliminarPerroAdopcion,
      marcarAdoptado
    };
  },
  mounted() {
    this.loadPerros();
    this.mostrarPopupM();
  },
});
</script>
