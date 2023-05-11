<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->

  <div class="bg-white full-height full-width" style="height: 97vh">
    <div class="titulo text-center text-h4 text-bold text-primary q-pt-md">
      MIS PERROS
    </div>
    <q-card stretch flat class="bg-white full-width full-height column">
      <q-separator></q-separator>
        
          <q-scroll-area
            :thumb-style="thumbStyle"
            :bar-style="barStyle"
            style="height: 88vh; width: 100%"
            class="bg-white full-width"
          >
            <div class="full-width row items-justify justify-center">
              <TarjetaPerro class="q-py-sm"
                v-for="perro of perrosDatos"
                :key="perro.IDPERROADOPCION"
                :rol="rol"
                :nombre="perro.NOMBRE"
                :edad="perro.EDAD"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :raza="perro.RAZA"
                linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
              />
            </div>
          </q-scroll-area>

    </q-card>

    
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
import TarjetaPerro from "./tarjetas/TarjetaPerro.vue";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js";

export default defineComponent({
  name: "PaginaPerros",
  components: {
    TarjetaPerro,
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
