<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <q-card
    flat
    class="my-card bg-primary text-white q-ma-md full-width"
    style="width: 55rem; max-width: 55rem; max-height: 40rem"
  >
    <q-tabs
      v-model="tab"
      dense
      class="text-white text-h5 text-bold q-py-xs full-width"
      active-color="white"
      indicator-color="secondary"
      align="justify"
      narrow-indicator
    >
      <q-tab name="datos" label="datos" />
       <q-tab name="turnos" label="historial médico" /> 
    </q-tabs>

    <q-tab-panels v-model="tab" animated class="full-width">
      <q-tab-panel name="datos" class="bg-primary">
        <q-card-section horizontal>
          <q-img
            class="col-5 q-pb-none"
            fit="cover"
            src="https://shorturl.at/mnsL0"
          />

          <q-card-section class="column col-7 justify-between">
            <div class="">
              <div class="text-h5 text-uppercase text-bold q-pr-sm q-pb-sm">
                {{ perro.NOMBRE }}
              </div>
              <q-separator dark></q-separator>
              <div class="row q-pt-sm">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Raza:</div>
                <div>{{ perro.RAZA }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Tamaño:</div>
                <div>{{ perro.TAMANIO }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Peso:</div>
                <div>{{ perro.PESO }} kg</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Edad:</div>
                <div>{{ formattedDate }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
                <div>{{ perro.SEXO }}</div>
              </div>
              <div class="row">
                <div class="textoTituloPosteo q-pr-sm q-pb-xs">Color:</div>
                <div>{{ perro.COLOR }}</div>
              </div>
              <q-separator class="q-mt-xs" dark />
            </div>

            <q-card-actions class="row justify-end items-center self-end">
              <!-- <q-btn flat v-if="rol >= 1" class="textoBoton">
              Ver historial
            </q-btn>
          <q-btn flat class="textoBoton"> Editar datos </q-btn> -->
              <q-btn @click="confirmar = true" flat class="textoBoton"
              >
                Eliminar
              </q-btn>
              <q-btn @click="edicionPerro = true"  flat class="textoBoton" 
              >
                Editar datos
              </q-btn>
            </q-card-actions>
          </q-card-section>
        </q-card-section>
      </q-tab-panel>


    <q-tab-panel name="turnos" class="bg-primary">
        <div horizontal style="width: 55rem; max-width: 55rem; max-height: 40rem">
          <TarjetaHistorial :nombrePerro="perro.NOMBRE" />
        </div>
    </q-tab-panel>

    </q-tab-panels>

    <q-dialog v-model="edicionPerro">
        <FormPerro 
        @editarPerro="editarPerro" 
        :nombresPerros="nombresPerros" 
        :COLOR="perro.COLOR"
        :NOMBRE="perro.NOMBRE"
        :TAMANIO="perro.TAMANIO"
        :NACIMIENTO="perro.NACIMIENTO"
        :SEXO="perro.SEXO"
        :RAZA="perro.RAZA"
        :PESO="perro.PESO"
        />
      </q-dialog>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Eliminar perro?</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Eliminar"
            @click="eliminarPerro(nombre)"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Cancelar" color="primary"  />
        </q-card-actions>
      </q-card>
    </q-dialog>

  </q-card>
</template>

<script>
import { defineComponent, ref } from "vue";
import TarjetaHistorial from "./TarjetaHistorial.vue"
import FormPerro from "../formulariosEditar/formPerro.vue";
import { api } from "../../boot/axios.js";
import { useStore } from '../../pinia/store.js'


export default defineComponent({
  name: "TarjetaPerroVet",
  components: {
    TarjetaHistorial,
    FormPerro,
  },
  props: {
    dni:String,
    rol: String,
    nombresPerros: {
      type: Array,
      required: true,
    },
    perro: {
      type: Object,
      required: true,
      default: () => ({ NOMBRE: "", TAMANIO: "" }), // Set a default empty value for the prop
    },
  },
  setup(props, context) {
    const tab = ref("datos");
    const edicionPerro = ref(false);
    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    }

    const editarPerro = async (perroEditado) => {
      try {
        var perro={
            dnicliente: props.dni,
            nombre:perroEditado.nombre,
            peso:perroEditado.peso,
            sexo:perroEditado.sexo,
            color:perroEditado.color,
            nacimiento:perroEditado.nacimiento,
            tamanio:perroEditado.tamanio,
            nombreA:perroEditado.nombreA,
          }
        const response = await api.post("/perro/editarPerro",{
          perro,
          quienSoy: quienSoy,
        })
        context.emit("loadPerrosCliente")
        context.emit("cerrarPerro")
      } catch (error) {
        console.error(error);
      }}
    return {
      tab,
      confirmar: ref(false),
      edicionPerro,
      editarPerro,
    };
  },
  methods: {
    eliminarPerro() {
      this.$emit("eliminarPerro",this.perro.NOMBRE);
      //this.$emit("loadPerrosCliente",this.dni)
      this.$emit("close");
    },
  },
  computed: {
    formattedDate() {
      const currentDate = new Date();
      const date = new Date(this.perro.NACIMIENTO);
      const diff = Math.abs(currentDate - date);

      const millisecondsPerDay = 24 * 60 * 60 * 1000;
      const days = Math.floor(diff / millisecondsPerDay);

      const years = Math.floor(days / 365);
      const months = Math.floor((days % 365) / 30);
      const remainingDays = days - years * 365 - months * 30;

      let formattedDate = "";

      if (years > 0) {
        formattedDate += years === 1 ? "1 año" : `${years} años`;
      }
      if (months > 0) {
        formattedDate += `${years > 0 ? ", " : ""}${months === 1 ? "1 mes" : `${months} meses`}`;
      }
      if (remainingDays > 0) {
        formattedDate += `${(years > 0 || months > 0) ? ", " : ""}${remainingDays === 1 ? "1 día" : `${remainingDays} días`}`;
      }

      return formattedDate;
    }
  }
});
</script>
