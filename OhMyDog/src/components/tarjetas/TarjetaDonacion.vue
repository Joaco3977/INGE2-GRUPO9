<template>
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 55vw"
    >
      <!-- style="min-width: 20rem; max-width: 25rem" -->

      <q-card-section v-if="rol == 2">
        <div class="row justify-end full-width">
          <q-btn class="q-ml-md" color="accent">
            <div>Editar</div>
          </q-btn>
          <q-btn @click="confirmar = true" class="q-ml-md" color="accent">
            <div>Eliminar</div>
          </q-btn>
        </div>
      </q-card-section>
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

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Eliminar campaña?</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Eliminar"
            @click="eliminarDonacion(id)"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="donar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Realizar donación</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Ingrese un monto a donar mayor que 0
        </q-card-section>

        <q-input
          class="q-px-lg"
          filled
          v-model="donacion.monto"
          label="Monto en pesos"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Donar"
            :disabled="!montoValido"
            @click="realizarDonacion(link)"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Cancelar"  @click="reset()" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
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
