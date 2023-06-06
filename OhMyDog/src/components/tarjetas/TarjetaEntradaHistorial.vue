<template>
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 55vw"
    >
      <!-- style="min-width: 20rem; max-width: 25rem" -->
      <q-card-section>
        <!-- Contenido -->
        <div class="row no-wrap">
          <div class="column col-12 justify-start q-pl-sm">
            <div class="row items-baseline q-pb-sm">
              <q-icon name="ion-heart" size="2rem" />
              <div class="textoComillas q-pl-md q-pb-md">{{ nombre }}</div>
            </div>
            <div class="bg-info q-mt-md q-mr-lg q-pa-md">
              <div class="row">
                <div class="textoTituloPosteo q-mr-md q-pb-xs">Descripción</div>
                <div>{{ descripcion }}</div>
              </div>
            </div>
            <!-- Acciones -->
            <div class="col-grow"></div>
            <q-card-actions class="column">
              <q-separator dark />

              <q-btn
                flat
                class="textoBoton"
                @click="donar = true"
                target="_blank"
              >
                Realizar una donación
              </q-btn>
            </q-card-actions>
          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "TarjetaDonacion",
  components: {},
  props: {
    rol: String,
    id: String,
    nombre: String,
    descripcion: String,
    link: String,
  },
  setup() {
    
    const donacion = ref({
      dniCliente: "",
      nombreDonacion: "",
      monto: "",
    });

    return {
      confirmar: ref(false),
      donar: ref(false),
      donacion,
    };
  },
  methods: {
    realizarDonacion(link) {
      //Aca hariamos lo q se tenga q hacer cuadno donamos
      console.log("Realizar donacion al link: ", link);
    },
    eliminarDonacion(id) {
      this.$emit("eliminarDonacion", id);
    },
    reset(){
      this.donacion.monto = "";
    }
  },
  mounted() {},
  computed: {
    montoValido() {
      return /^\d+$/.test(this.donacion.monto) && parseInt(this.donacion.monto) > 0;
    },
  },
});
</script>
