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
        <q-tab @click="loadPerros" name="perrosOtros" label="¡Adoptá un perro!" />
        <q-tab @click="loadPerrosPropios"
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
              <TarjetaAdopcion @eliminarPerroAdopcion="eliminarPerroAdopcion"
                v-for="perro of perrosDatos"
                :key="perro.IDPERROADOPCION"
                :rol="rol"
                :dnicliente="perro.DNICLIENTE"
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
              <TarjetaAdopcion @eliminarPerroAdopcion="eliminarPerroAdopcion"
                v-for="perro of perrosDatos"
                :key="perro.IDPERROADOPCION"
                :rol="rol"
                :dnicliente="perro.DNICLIENTE"
                :servicio="servicio2"
                :nombre="perro.NOMBRE"
                :edad="perro.EDAD"
                :tamanio="perro.TAMANIO"
                :sexo="perro.SEXO"
                :telefono="perro.TELEFONO"
                :mail="perro.MAIL"
                :comentario="perro.COMENTARIO"
                :adoptado ="perro.ADOPTADO"
              />
            </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="mostrarPopup">
      <formAdopcion @registrarPerro="registrarPerro"/>
    </q-dialog>
  </div>
</template>

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
    formAdopcion,
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
        const response = await api.get("/perroAdopcion/getPerrosAdopcion");
        perrosDatos.value = response.data;
        console.log(perrosDatos.value[0])
      } catch (error) {
        console.error(error);
      }
    };

    const registrarPerro = async (perro) => {
      try {
        console.log(useStore().dni);
        const response = await api.post("/perroAdopcion/addPerroAdopcion", {
          perro
        });
        if(tab.value == "perrosOtros"){
          loadPerros();
        }else{
          loadPerrosPropios();
        }
      } catch (error) {
        console.error(error);
      }
    };

    async function eliminarPerroAdopcion (data) {
      try {
        await api.post("perroAdopcion/deletePerroAdopcion", {
          dniQuien: useStore().dni,
          dnicliente: data.dnicliente,
          nombre: data.nombre,
          rol: useStore().rol
        })
        if(tab.value == "perrosOtros"){
          loadPerros();
        }else{
          loadPerrosPropios();
        }
      } catch {
        console.error('No es posible eliminar al perro en adopcion')
      }
    }

    const loadPerrosPropios = async () => {
      try {
        const response = await api.post("/perroAdopcion/getPerrosAdopcionPropios",{ dni : useStore().dni })
        perrosDatos.value = response.data;
      }
      catch (error) {
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
      perrosDatos,
      loadPerros,
      loadPerrosPropios,
      mostrarPopupM,
      mostrarPopup,
      rol,
      servicio1,
      servicio2,
      eliminarPerroAdopcion
    };
  },
  mounted() {
    this.loadPerros();
    this.mostrarPopupM();
  },
});
</script>
