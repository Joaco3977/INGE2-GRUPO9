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
          <q-btn
            @click="MostrarPopEditar = true"
            class="q-ml-md"
            color="accent"
          >
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
              <div class="row">
                <div class="textoTituloPosteo q-mr-md q-pb-xs">Objetivo</div>
                <div>Se recaudaron {{ montoActual }}/{{ montoEsperado }} del monto objetivo! Contribuye con tu donacion.</div>
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
          maxlength="100"
          mask="######"
          v-model="donacion.monto"
          label="Monto en pesos"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Cancelar"
            @click="resetMonto()"
            color="primary"
            v-close-popup
          />

          <q-btn
            flat
            label="Donar"
            :disabled="!montoValido"
            @click="abrirFormTarjeta = true"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog persistent v-model="abrirFormTarjeta" class="">
      <formTarjeta @pagarConTarjeta="pagarConTarjeta" :cantidad="donacion.monto" :link="link" />
    </q-dialog>

    <q-dialog v-model="MostrarPopEditar" class="">
      <formDonacion
        @editarDonacion="editarDonacion"
        :Anombre="nombre"
        :Adescripcion="descripcion"
        :nombreDonaciones="nombreDonaciones"
        :AmontoEsperado="montoEsperado"
      />
    </q-dialog>

    <q-dialog v-model="MostrarPopPagoTarjeta">
      <q-card>

        <q-card-section class="q-pt-none">
          {{ mensajePagoTarjeta }}
        </q-card-section>

        <q-card-actions align="right">
          <q-btn v-if="!pagoAprobado" flat label="Aceptar" color="primary" v-close-popup />
          <q-btn v-if="pagoAprobado"
            flat
            label="Aceptar"
            @click="() => { abrirFormTarjeta = false; sumarBonusCliente(); setMontoActual()}"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { useStore } from "src/pinia/store";
import { defineComponent, ref } from "vue";
import formTarjeta from "../formularios/formTarjeta.vue";
import formDonacion from "../formulariosEditar/formDonacion.vue";
import { api } from "src/boot/axios";

const numerosValidos = ['1111-2222-3333-4444', '0000-0000-0000-0000']

export default defineComponent({
  name: "TarjetaDonacion",
  components: {
    formTarjeta,
    formDonacion,
  },
  props: {
    rol: String,
    id: String,
    nombre: String,
    descripcion: String,
    montoEsperado: String,
    nombreDonaciones: {
      type: Array,
      required: true,
    },
  },
  setup(props, { emit }) {
    const abrirFormTarjeta = ref(false);
    const MostrarPopEditar = ref(false);
    const MostrarPopPagoTarjeta = ref(false);
    const pagoAprobado = ref (false)

    const mensajePagoTarjeta = ref('')


    const montoActual = ref(0)

    const setMontoActual = async() => {
      await api.post('/donacion/getMontoActual', {
        id: props.id
      })
      .then((response) => {
        montoActual.value = response.data.total
      })
      .catch((error) => {
        console.log(error)
      })
    }

    const donacion = ref({
      dniCliente: useStore().dni,
      nombreDonacion: props.nombre,
      monto: "",
    });

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    };

    const editarDonacion = async (donacion) => {
      try {
        MostrarPopEditar.value = false;
        const response = await api.post("/donacion/editarDonacion", {
          donacion,
          quienSoy: quienSoy,
        });
        emit("loadDonaciones");
      } catch (error) {
        console.error(error);
      }
    };

    const pagarConTarjeta = async (data) => {
      if (data.tarjeta.titular === 'Renzo Gigena' && data.tarjeta.codigo === '111' && numerosValidos.includes(data.tarjeta.numero)) {
        if (data.tarjeta.numero === '1111-2222-3333-4444') {
          let dniCliente = null
          if (useStore().rol === 1) {
            dniCliente = useStore().dni
          }
          try {
            await api.post('/donacion/donar', {
              id: props.id,
              dniCliente: dniCliente,
              cantidad: donacion.value.monto,
            })
            .then(() => {
              mensajePagoTarjeta.value = `El pago fue realizado con exito, has obtenido un bonus de ${donacion.value.monto * 0.10}$ para tu proxima consulta`
              pagoAprobado.value = true
              MostrarPopPagoTarjeta.value = true
            })
            .catch((error) => {
              console.log(error)
            })
          } catch (error2) {
            console.log(error2)
          }
        } else {
          mensajePagoTarjeta.value = 'La tarjeta no cuenta con los fondos suficientes'
          pagoAprobado.value = false
          MostrarPopPagoTarjeta.value = true
        }
      } else {
        mensajePagoTarjeta.value = 'Los datos de la tarjeta no son validos'
        pagoAprobado.value = false
        MostrarPopPagoTarjeta.value = true
      }
    }

    const sumarBonusCliente = async () => {
      console.log(useStore().rol)
      if (useStore().rol === 1) {
        try {
          api.post('/donacion/sumarBonus', {
            dni: useStore().dni,
            bonus: donacion.value.monto * 0.10,
          })
        } catch (error) {
          console.log(error)
        }
      }
    }

    return {
      MostrarPopEditar,
      abrirFormTarjeta,
      editarDonacion,
      confirmar: ref(false),
      donar: ref(false),
      pagoTarjeta: ref(false),
      donacion,
      pagarConTarjeta,
      MostrarPopPagoTarjeta,
      pagoAprobado,
      mensajePagoTarjeta,
      sumarBonusCliente,
      montoActual,
      setMontoActual
    };
  },
  methods: {
    eliminarDonacion(id, nombre) {
      const data = {
        id: id,
        nombre: nombre,
      };
      this.$emit("eliminarDonacion", data);
    },
    resetMonto() {
      this.donacion.monto = "";
    },
  },
  mounted() {
    this.setMontoActual()
  },
  computed: {
    montoValido() {
      return (
        /^\d+$/.test(this.donacion.monto) &&
        parseInt(this.donacion.monto) > 0
      );
    },
    camposValidos() {
      return (
        this.tarjeta.numero.length > 0 &&
        this.tarjeta.titular.length > 0 &&
        this.tarjeta.vencimiento.length > 0 &&
        this.tarjeta.codigo.length > 0
      );
    },
  },
});
</script>
