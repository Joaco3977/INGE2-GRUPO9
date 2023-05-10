<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->

  <div class="bg-white full-height full-width" style="height: 97vh">
    <div class="titulo text-center text-h4 text-bold text-primary q-pt-md">
      ADOPCIONES
    </div>
    <q-card stretch flat class="bg-white full-width full-height column">
      <q-btn
        v-if="rol > 0"
        @click="mostrarPopupM"
        color="accent"
        class="q-ma-md q-mr-xl self-end"
        style="width: 20em"
      >
        <div class="textoBoton">Agregar perro para adopción</div>
      </q-btn>

      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <!-- EN ESTA ETIQUETA VA @click="loadPerros" y a su vez tambien va en el mounted para que cargue de entrada todos los perros disponible ( faltaria agregar un label que informe cuando no hya perros (vectordedatos vuelve vacio de db))-->
        <q-tab name="perrosOtros" label="¡Adoptá un perro!" />
        <q-tab
          v-if="rol === 1"
          name="perrosPropios"
          label="Mis perros en adopción"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated>
        <q-tab-panel name="perrosOtros">
          <!-- <q-btn
            v-if="rol === 2"
            @click="mostrarPopupM"
            color="accent"
            class="q-ma-md q-mr-xl self-end"
            style="width: 20em"
          >
            <div class="textoBoton">¡Poné un perro en adopción!</div>
          </q-btn> -->
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 75vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify">
              <TarjetaAdopcion
                v-for="perro of perrosDatos"
                :key="perro.IDPERROADOPCION"
                :rol="rol"
                :servicio="servicio1"
                :nombre="perro.NOMBRE"
                :edad="perro.EDAD"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :telefono="perro.TELEFONO"
                :mail="perro.MAIL"
                :comentario="perro.COMENTARIO"
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="perrosPropios" class="column">
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 60vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify">
              <TarjetaAdopcion
                v-for="perro of perrosDatos"
                :key="perro.IDPERROADOPCION"
                :rol="rol"
                :servicio="servicio2"
                :nombre="perro.NOMBRE"
                :edad="perro.EDAD"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :telefono="perro.TELEFONO"
                :mail="perro.MAIL"
                :comentario="perro.COMENTARIO"
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <div class="paraform" style="width: 50vw; height: 80vh">
        <q-form class="q-pa-xl" @submit.prevent="registrarPerro">
          <q-input
            v-model="perroNOMBRE"
            clearable
            class="q-px-xl"
            label="Nombre"
            type="text"
          />
          <q-select
            v-model="peroTAMANIO"
            :options="opcionTamanio"
            class="q-px-xl"
            label="Tamaño"
          />
          <q-input
            v-model="perroEDAD"
            clearable
            class="q-px-xl"
            label="Edad Aproximada"
            type="text"
          />
          <q-select
            v-model="peroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />
          <q-input
            v-model="perroTELEFONO"
            clearable
            class="q-px-xl"
            label="Telefono"
            type="number"
          />
          <q-input
            v-model="perroMAIL"
            clearable
            class="q-px-xl"
            label="Mail"
            type="email"
          />
          <q-input
            v-model="perroCOMENTARIO"
            clearable
            class="q-px-xl"
            label="Comentarios"
            type="text"
          />
          <q-btn
            push
            class="q-my-md q-mx-xl"
            color="accent"
            type="submit"
            label="Registrar Perro"
          />
        </q-form>
      </div>
    </q-dialog>
  </div>
</template>

<style>
.paraform {
  background-color: #fff;
}
</style>

<script>
import { defineComponent } from "vue";
import { ref, reactive } from "vue";
import { QDialog } from "quasar";
import TarjetaAdopcion from "./tarjetas/TarjetaAdopcion.vue";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";
import formAdopcion from "./formularios/formPerroAdopcion.vue";

export default defineComponent({
  name: "PaginaAdopciones",
  components: {
    TarjetaAdopcion,
    QDialog,
    //formAdopcion,
  },
  setup() {
    const perrosDatos = ref([]);
    const perroSEXO = ref("");
    const perroTAMANIO = ref("");
    const perroEDAD = ref("");
    const perroTELEFONO = ref("");
    const perroNOMBRE = ref("");
    const perroMAIL = ref("");
    const perroCOMENTARIO = ref("");
    const perroDNICLIENTE = useStore().dni;
    const mostrarPopup = ref("false");
    const rol = useStore().rol;

    const servicio1 = "perrosOtros";
    const servicio2 = "perrosMios";

    const loadPerros = async () => {
      try {
        const response = await api.get("/perroAdopcion/getPerrosAdopcion");
        perrosDatos.value = response.data;
      } catch (error) {
        console.error(error);
      }
    };

    const registrarPerro = async () => {
      try {
        console.log(useStore().dni);
        const response = await api.post("/perroAdopcion/addPerroAdopcion", {
          perro: {
            sexo: perroSEXO.value,
            tamanio: perroTAMANIO.value,
            edad: perroEDAD.value,
            telefono: perroTELEFONO.value,
            nombre: perroNOMBRE.value,
            mail: perroMAIL.value,
            comentario: perroCOMENTARIO.value,
            dnicliente: perroDNICLIENTE,
          },
        });
        await loadPerros();
      } catch (error) {
        console.error(error);
      }
    };

    /*
    const loadPerrosPropios = async () => {
      try {
        const response = await api.post("/perroAdopcion/getPerrosAdopcionPropios",{ useStore.dni })
          perrosDatos.value = response.data;
      }
      catch (error) {
        console.error(error);
      }
    };

*/
    const mostrarPopupM = () => {
      mostrarPopup.value = !mostrarPopup.value;
    };

    return {
      tab: ref("perrosOtros"),
      store: useStore(),
      servicioActual: "adopciones",
      misAdopciones: "misPerros",
      perroEDAD,
      perroSEXO: "",
      opcionSexo: [
        { label: "Macho", value: "Macho" },
        { label: "Hembra", value: "Hembra" },
      ],
      perroTAMANIO: "",
      opcionTamanio: [
        { label: "Pequeño", value: "Pequeño" },
        { label: "Mediano", value: "Mediano" },
        { label: "Grande", value: "Grande" },
      ],
      perroTELEFONO,
      perroNOMBRE,
      perroMAIL,
      perroCOMENTARIO,
      perroDNICLIENTE,
      registrarPerro,
      perrosDatos,
      loadPerros,
      mostrarPopupM,
      mostrarPopup,
      rol,
      servicio1,
      servicio2,
    };
  },
  mounted() {
    this.loadPerros();
    this.mostrarPopupM();
  },
});
</script>
