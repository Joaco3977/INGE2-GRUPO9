<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md"
      style="width: 20rem"
    >
      <q-card-section
        v-if="encontrado == 1"
        class="bg-primary textoNoItems text-white"
      >
        ¡ENCONTRADO!
      </q-card-section>
      <q-card-section v-if="servicio === 'perrosMios' || rol === 2">
        <div class="row justify-end full-width">
          <q-btn
            @click="mostrarPopupEditar = true"
            v-if="servicio === 'perrosMios' || rol === 2 || encontrado == 0"
            class=""
            color="accent"
          >
            <div>Editar</div>
          </q-btn>
          <q-btn
            v-if="servicio === 'perrosMios' || rol === 2 || encontrado == 0"
            @click="confirmar = true"
            class="q-ml-sm"
            color="accent"
          >
            <div>Eliminar</div>
          </q-btn>

          <!-- @click="ejecutarFuncionPadre(dnicliente, nombre)" -->
        </div>
      </q-card-section>
      <q-card-section>
        <!-- Contenido -->
        <div class="column">
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Nombre:</div>
            <div>{{ nombre }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">
              Fecha de pérdida:
            </div>
            <div>{{ fecha }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">
              Zona de pérdida:
            </div>
            <div>{{ zona }} meses</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">Sexo:</div>
            <div>{{ sexo }}</div>
          </div>
          <div v-if="encontrado == 0" class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">
              Teléfono de contacto:
            </div>
            <div>{{ telefono }}</div>
          </div>
        </div>
      </q-card-section>
      <q-separator dark />
      <q-card-section v-if="comentario !== ''" class="bg-info">
        <div class="column items-center">
          <div class="textoComentario">
            <b class="textoComillas"> " </b>
            {{ comentario }}
            <b class="textoComillas"> " </b>
          </div>
        </div>
      </q-card-section>
      <!-- Acciones -->
      <q-separator dark />
      <q-card-actions v-if="encontrado == 0" class="column items-center">
        <q-btn
          @click="confirmarEncontrado = true"
          flat
          v-if="servicio === 'perrosMios' || rol == 2"
          class="textoBoton"
        >
          Marcar como encontrado
        </q-btn>
        <q-btn
          flat
          v-else
          class="textoBoton"
          :href="convertirContacto()"
          target="_blank"
        >
          Contactar dueño
        </q-btn>
      </q-card-actions>
    </q-card>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Eliminar perro?</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />

          <q-btn
            flat
            label="Eliminar"
            @click="ejecutarFuncionPadre(dnicliente, nombre)"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="confirmarEncontrado">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">
            ¿Marcar perro como encontrado?
          </div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
          <q-btn
            flat
            label="Confirmar"
            @click="marcarAdoptado(id)"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog ref="popup1" v-model="mostrarPopupEditar">
      <formPerroAdopcion
        @editarPerro="editarPerro"
        :nombre="nombre"
        :fecha="fecha"
        :zona="zona"
        :sexo="sexo"
        :comentario="comentario"
        :telefono="telefono"
        :id="id"
      />
    </q-dialog>
  </div>
</template>

<script>
import { useQuasar } from "quasar";
import { defineComponent, ssrContextKey } from "vue";
import { ref } from "vue";
import formPerroAdopcion from "../formulariosEditar/formPerroAdopcion.vue";
import { useStore } from "../../pinia/store.js";

export default defineComponent({
  name: "TarjetaPerdido",
  components: {
    formPerroAdopcion,
  },
  props: {
    id: String,
    rol: String,
    servicio: String,
    nombre: String,
    zona: String,
    fecha: String,
    sexo: String,
    telefono: String,
    comentario: String,
    encontrado: String,
    dnicliente: String,
  },
  setup(props, { emit }) {
    const mostrarPopupEditar = ref(false);

    const editarPerro = async (perroEditado) => {
      mostrarPopupEditar.value = false;
      var perro = {
        id: props.id,
        nombre: perroEditado.nombre,
        sexo: perroEditado.sexo,
        fecha: perroEditado.fecha,
        zona: perroEditado.zona,
        comentario: perroEditado.comentario,
        telefono: perroEditado.telefono,
      };
      emit("editarPerro", perro);
    };
    return {
      editarPerro,
      mostrarPopupEditar,
      contactoCliente: "",
      confirmar: ref(false),
      confirmarEncontrado: ref(false),
    };
  },
  methods: {
    closePopup() {
      this.$refs.popup1.hide();
    },
    convertirContacto() {
      let cont = "";
      cont =
        "https://api.whatsapp.com/send?phone=" +
        this.telefono +
        "&text=Contacto%20desde%20OhMyDog%20por%20perro%20perdido%20" +
        this.nombre;

      return cont;
    },
    ejecutarFuncionPadre(dnicliente, nombre) {
      const data = {
        dnicliente: dnicliente,
        nombre: nombre,
      };
      this.$emit("eliminarPerroAdopcion", data);
    },
    marcarAdoptado(id) {
      this.$emit("marcarAdoptado", id);
    },
  },
  mounted() {},
});
</script>
