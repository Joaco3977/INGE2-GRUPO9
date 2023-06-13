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
            @click="eliminarDonacion(id, nombre)"
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
          Ingrese un monto a donar:
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
            @click="abrirFormTarjeta = true"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Cancelar"  @click="resetMonto()" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog persistent v-model="abrirFormTarjeta" class="">
      <formTarjeta :cantidad="donacion.monto"  :link="link"/>
    </q-dialog>

  </div>
</template>

<script>
import { useStore } from "src/pinia/store";
import { defineComponent, ref } from "vue";
import formTarjeta from '../formularios/formTarjeta.vue'

export default defineComponent({
  name: "TarjetaDonacion",
  components: {
    formTarjeta,
  },
  props: {
    rol: String,
    id: String,
    nombre: String,
    descripcion: String,
    link: String,
  },
  setup(props) {

    const abrirFormTarjeta= ref(false);

    const donacion = ref({
      dniCliente: useStore().dni,
      nombreDonacion: props.nombre,
      monto: "",
    });

    const tarjeta = ref({
      numero: '',
      titular: '',
      vencimiento: '',
      codigo: ''
    })

    return {
      abrirFormTarjeta,
      confirmar: ref(false),
      donar: ref(false),
      pagoTarjeta: ref(false),
      donacion,
      tarjeta,
    };
  },
  methods: {
    async initiatePayment() {

    },
    eliminarDonacion(id, nombre) {
      const data = {
        id: id,
        nombre: nombre
      }
      this.$emit("eliminarDonacion", data);
    },
    resetMonto(){
      this.donacion.monto = "";
    },
    resetTarjeta(){
      this.tarjeta.numero = '';
      this.tarjeta.titular = '';
      this.tarjeta.vencimiento = '';
      this.tarjeta.codigo = '';
    }
  },
  mounted() {},
  computed: {
    montoValido() {
      return /^\d+$/.test(this.donacion.monto) && parseInt(this.donacion.monto) > 0 && parseInt(this.donacion.monto) < 1000000;
    },
    camposValidos() {
      return this.tarjeta.numero.length > 0 && this.tarjeta.titular.length > 0 && this.tarjeta.vencimiento.length > 0 && this.tarjeta.codigo.length > 0;
    },
  },
});
</script>
