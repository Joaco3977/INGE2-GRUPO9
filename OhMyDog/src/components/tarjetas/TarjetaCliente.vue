<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full">
    <q-card class="my-card bg-white text-white q-ma-md" style="width: 75vw">
      <q-card-section class="bg-primary">
        <div class="row justify-between full-width">
          <div class="textoPerfil q-pl-md">
            {{ nombreApellido }}
          </div>
          <div>
            <q-btn
              @click="mostrarPopupEditar = true"
              color="accent"
              class=""
              style="width: max-content; height: max-content"
            >
              <div>Editar</div>
            </q-btn>
            <q-btn @click="confirmar = true" class="q-ml-sm" color="accent">
              <div>Eliminar</div>

              <!-- @click="ejecutarFuncionPadre(dni)"-->
            </q-btn>
            <q-btn @click="mostrarPopupBonus = true" class="q-ml-sm" color="accent">
              <div>Bonus</div>
            </q-btn>
          </div>
        </div>
      </q-card-section>
      <q-card-section>
        <!-- Contenido -->
        <div class="row text-dark">
          <div class="column col-4">
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">DNI:</div>
              <div>{{ dni }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">
                Nombre y Apellido:
              </div>
              <div>{{ nombreApellido }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Mail:</div>
              <div>{{ mail }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Teléfono:</div>
              <div>{{ telefono }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Dirección:</div>
              <div>{{ direccion }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Bonificacion por donar:</div>
              <div>{{ montoBonificacion }}$ pesos argentinos</div>
            </div>
          </div>

          <div class="column col-5">
            <q-expansion-item
              v-model="expandedItem"
              @click="loadPerrosCliente(dni)"
              class="full-width bg-primary text-white text-center text-bold"
              expand-separator
              icon="ion-paw"
              expand-icon="ion-arrow-dropdown"
              label="Ver perros del cliente"
            >
              <q-card flat>
                <div
                  class="row text-bold text-secondary text-center justify-center full-height content-center q-pa-md q-mx-lg"
                  v-if="perrosCliente.length === 0"
                >
                  ¡Este cliente no tiene ningún perro!
                </div>
                <q-card-section>
                  <div class="column justify-center">
                    <q-btn
                      v-for="perro in perrosCliente"
                      :key="perro"
                      @click="
                        verPerro = true;
                        perroElegido = perro;
                      "
                      class="q-mx-lg q-mb-sm"
                      color="secondary"
                    >
                      <div class="textoBoton text-bold">{{ perro.NOMBRE }}</div>
                    </q-btn>
                  </div>
                </q-card-section>
              </q-card>
            </q-expansion-item>
          </div>

          <div class="column col-3 justify-center content-end">
            <q-btn
              class="textoBoton q-ml-lg"
              color="accent"
              @click="agregarPerro = true"
            >
              Agregar perro
            </q-btn>
          </div>
        </div>
      </q-card-section>
      <q-card-actions class="column items-center">
        <!-- <q-btn push class="textoBoton"  flat> Editar </q-btn> -->
      </q-card-actions>
    </q-card>

    <q-dialog v-model="verPerro">
      <TarjetaPerroVet
        :perro="perroElegido"
        @eliminarPerro="eliminarPerro"
        @loadPerrosCliente="loadPerrosCliente"
        @cerrarPerro="cerrarPerro"
        :nombresPerros="nombresPerros"
        :dni="dni"
      />
    </q-dialog>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Eliminar cliente?</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />

          <q-btn
            flat
            label="Eliminar"
            @click="ejecutarFuncionPadre(dni)"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="agregarPerro">
      <FormPerro
        @registrarPerro="registrarPerro"
        :nombresPerros="nombresPerros"
        :dnicliente="dni"
      />
    </q-dialog>

    <q-dialog v-model="mostrarPopupBonus">
      <FormBonus
        @loadClientes="loadClientes"
        :dniCliente="dni"
        :montoBonificacion="montoBonificacion"
      />
    </q-dialog>

    <q-dialog v-model="mostrarPopupEditar">
      <FormClienteEditar
        @editarCliente="editarCliente"
        :dni="dni"
        :nombreApellido="nombreApellido"
        :mail="mail"
        :telefono="telefono"
        :direccion="direccion"
        :mailsClientes="mailsClientes"
        :mailsVeterinarios="mailsVeterinarios"
        :dniClientes="dniClientes"
      />
    </q-dialog>
  </div>
</template>

<script>
import { api } from "src/boot/axios";
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaPerroVet from "./TarjetaPerroVet.vue";
import FormPerro from "../formularios/formPerro.vue";
import FormClienteEditar from "../formulariosEditar/formCliente.vue";
import FormBonus from "../formulariosEditar/formBonus.vue";
import { normalizeString } from "src/functions/misc";
import { useStore } from "../../pinia/store.js";

export default defineComponent({
  name: "TarjetaCliente",
  components: {
    TarjetaPerroVet,
    FormPerro,
    FormClienteEditar,
    FormBonus,
},
  props: {
    dni: String,
    nombreApellido: String,
    mail: String,
    telefono: String,
    direccion: String,
    mailsClientes: {
      type: Array,
      required: true,
    },
    mailsVeterinarios: {
      type: Array,
      required: true,
    },
    dniClientes: {
      type: Array,
      required: true,
    },
    montoBonificacion: String,
  },
  setup(props) {
    const mostrarPopupEditar = ref(false);
    const mostrarPopupBonus = ref (false);
    const nombresPerros = ref([]);
    const perrosCliente = ref([]);
    const verPerro = ref(false);
    const perroElegido = ref("");
    const agregarPerro = ref(false)

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    };

    const registrarPerro = async () => {
      agregarPerro.value = false
      loadPerrosCliente();
    };

    const loadPerrosCliente = async () => {
      try {
        const response = await api.post("/perro/getPerrosPropios", {
          dni: props.dni,
        });
        perrosCliente.value = response.data;
        nombresPerros.value = response.data.map((perro) =>
          normalizeString(perro.NOMBRE)
        );
      } catch (error) {
        console.error(error);
      }
      verPerro.value = false;
    };

    const eliminarPerro = async (nombre) => {
      try {
        const response = await api.post("/perro/deletePerroPropio", {
          perro: {
            nombre: nombre,
            dnicliente: props.dni,
          },
          quienSoy: quienSoy,
        });
        verPerro.value = false;
        loadPerrosCliente();
      } catch (error) {
        console.log(error);
      }
    };

    const cerrarPerro = () => {
      //verPerro.value = false;
    };

    return {
      confirmar: ref(false),
      expandedItem: ref(false),
      nombresPerros,
      verPerro,
      agregarPerro,
      mostrarPopupEditar,
      perrosCliente,
      perroElegido,
      registrarPerro,
      eliminarPerro,
      loadPerrosCliente,
      cerrarPerro,
      mostrarPopupBonus
    };
  },
  methods: {
    loadClientes() {
      this.$emit('loadClientes', {})
      this.mostrarPopupBonus = false
    },
    ejecutarFuncionPadre(dni) {
      this.$emit("ejecutarFuncion", dni);
    },
    editarCliente(cliente) {
      this.mostrarPopupEditar = false;
      this.$emit("editarCliente", cliente);
    },
    recargarPerros() {
      this.loadPerrosCliente(this.dni);
      this.expandedItem = false;
    },
  },
  mounted() {
    this.loadPerrosCliente(this.dni);
  },
  beforeUnmount() {
    this.perrosCliente.value = [];
    this.expandedItem = false;
  },
});
</script>
