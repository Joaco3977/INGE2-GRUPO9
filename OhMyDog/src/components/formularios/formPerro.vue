<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar perro a cliente
        </div>
      </q-card-section>
      <q-card-section class="">
        <q-form class="q-px-xl" @submit.prevent="ejecutarFuncionPadre" reset>
          <q-input
            v-model="perroNOMBRE"
            class="q-px-xl"
            label="Nombre"
            type="text"
          />
          <div class="column items-center bg-white q-pa-sm">
            <q-uploader
              v-model="imagenElegida"
              ref="uploaderPerdido"
              label= "Foto del perro"
              accept="image/*"
              :field-name="'perroPerdidoImagen'"
              :form-fields="[
                {name: 'seccion', value: 'PERRO'},
                {name: 'id', value: 0}
              ]"
              url="http://localhost:5137/perro/subirImagenPerro"
              style="max-width: 300px"

              @added="imagenElegida = true"
              @removed="imagenElegida = false"
            />
          </div>
          <q-select
            v-model="perroTAMANIO"
            :options="opcionTamanio"
            class="q-px-xl"
            label="Tamaño"
          />
          <div class="column items-center bg-white q-pa-sm">
            <div class="q-px-xl q-py-sm text-start self-start color-grey">
              Fecha de nacimiento:
            </div>
            <q-date
              v-model="perroNACIMIENTO"
              minimal
              :options="opcionesFecha"
            />
          </div>
          <q-select
            v-model="perroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />
          <q-input
            v-model="perroCOLOR"
            class="q-px-xl"
            label="Color del perro"
            type="text"
          />
          <q-input
            v-model="perroRAZA"
            class="q-px-xl"
            label="Raza del perro"
            type="text"
          />
          <q-input
            v-model="perroPESO"
            class="q-px-xl"
            label="Peso del perro"
            type="number"
          />
          <ul class="q-mx-md q-py-xs">
            <li
              v-for="mnsj in mensajeError"
              :key="mnsj"
              class="bg-white text-accent text-bold"
            >
              {{ mnsj }}
            </li>
          </ul>
          <div class="row justify-end q-pt-lg">
            <q-btn
              label="Cancelar"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
              v-close-popup
            />
            <q-btn
              label="Registrar perro"
              @click="this.ejecutarFuncionPadre()"
              :disabled="!camposValidos"
              color="accent"
            />
          </div>
        </q-form>
      </q-card-section>
    </q-card>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useStore } from "src/pinia/store";
import { normalizeString } from "src/functions/misc";
import { api } from "src/boot/axios";
import { useQuasar } from "quasar";

export default defineComponent({
  name: "formPerro",
  props: {
    nombresPerros: {
      type: Array,
      required: true,
    },
    dnicliente: String,
  },
  setup(props) {
    const $q = useQuasar()

    const perroSEXO = ref("");
    const perroTAMANIO = ref("");
    const perroNACIMIENTO = ref("");
    const perroNOMBRE = ref("");
    const perroRAZA = ref("");
    const perroCOLOR = ref("");
    const perroPESO = ref("");

    const getDatosPerro = () => {
      let subioFoto;
      if (imagenElegida.value === true) {
        subioFoto = 1
      } else {
        subioFoto = 0
      }
      const perro = {
        sexo: perroSEXO.value.value,
        tamanio: perroTAMANIO.value.value,
        nacimiento: perroNACIMIENTO.value,
        raza: perroRAZA.value,
        color: perroCOLOR.value,
        nombre: perroNOMBRE.value,
        peso: perroPESO.value,
        dnicliente: props.dnicliente,
        foto: subioFoto
      };
      return perro;
    };

    const quienSoy = {
      rol: useStore().rol,
      dni: useStore().dni,
      nombre: useStore().nombre,
    };

    const onReset = () => {
      perroSEXO.value = "";
      perroTAMANIO.value = "";
      perroNACIMIENTO.value = "";
      perroNOMBRE.value = "";
      perroRAZA.value = "";
      perroCOLOR.value = "";
      perroPESO.value = "";
      return false;
    };

    const opcionesFecha = (date) => {
      const hoy = new Date().toLocaleDateString("zh-Hans-CN", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      const fechaHace25Anios = new Date();
      fechaHace25Anios.setFullYear(fechaHace25Anios.getFullYear() - 25);
      const fechaStr = fechaHace25Anios.toLocaleDateString("zh-Hans-CN", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      //console.log(date, hoy, fechaStr);
      return date <= hoy && date >= fechaStr;
    };

    const imagenElegida = ref(false)

    return {
      perroNACIMIENTO,
      perroSEXO,
      perroNOMBRE,
      perroRAZA,
      perroCOLOR,
      perroPESO,
      opcionSexo: [
        { label: "Macho", value: "Macho" },
        { label: "Hembra", value: "Hembra" },
      ],
      perroTAMANIO,
      opcionTamanio: [
        { label: "Pequeño", value: "Pequeño" },
        { label: "Mediano", value: "Mediano" },
        { label: "Grande", value: "Grande" },
      ],
      imagenElegida,
      quienSoy,
      getDatosPerro,
      onReset,
      opcionesFecha,
    };
  },
  methods: {
    async ejecutarFuncionPadre() {
      const perro = this.getDatosPerro();
      await api.post('/perro/addPerro', {
        perro: {
            nombre: perro.nombre,
            tamanio: perro.tamanio,
            color: perro.color,
            nacimiento: perro.nacimiento,
            sexo: perro.sexo,
            raza: perro.raza,
            peso: perro.peso,
            foto: perro.foto,
            dnicliente: perro.dnicliente,
          },
          quienSoy: this.quienSoy,
      })
      .then((result) => {
        this.$refs.uploaderPerdido.formFields[1].value = result.data.id
        this.$refs.uploaderPerdido.upload();
        this.$emit("registrarPerro");
      })
      .catch((error) => {
        console.log(error)
      })
    },
  },
  computed: {
    mensajeError() {
      let sError = [];
      if (!this.nombreValido) {
        sError.push("Ingrese un nombre válido");
      }
      if (this.nombreExiste) {
        sError.push("Un perro con este nombre ya está registrado");
      }
      if (!this.tamanioValido) {
        sError.push("El tamaño debe completarse");
      }
      if (!this.edadValida) {
        sError.push("Ingrese una fecha de nacimiento válida");
      }
      if (!this.sexoValido) {
        sError.push("El sexo debe completarse");
      }
      if (!this.colorValido) {
        sError.push("Ingrese un color válido");
      }
      if (!this.razaValido) {
        sError.push("Ingrese una raza válida");
      }
      if (!this.pesoValido) {
        sError.push("Ingrese un peso válido");
      }
      return sError;
    },
    nombreExiste() {
      return this.nombresPerros.includes(normalizeString(this.perroNOMBRE));
    },
    nombreValido() {
      return (
        this.perroNOMBRE.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.perroNOMBRE)
      );
    },
    colorValido() {
      return (
        this.perroCOLOR.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.perroCOLOR)
      );
    },
    razaValido() {
      return (
        this.perroRAZA.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.perroRAZA)
      );
    },
    tamanioValido() {
      return this.perroTAMANIO.value != undefined;
    },
    pesoValido() {
      return this.perroPESO.length > 0 && this.perroPESO > 0;
    },
    sexoValido() {
      return this.perroSEXO.value != undefined;
    },
    edadValida() {
      return this.perroNACIMIENTO.length >= 0;
    },
    camposValidos() {
      return (
        this.nombreValido &&
        !this.nombreExiste &&
        this.tamanioValido &&
        this.edadValida &&
        this.sexoValido &&
        this.colorValido &&
        this.pesoValido &&
        this.razaValido
      );
    },
  },
});
</script>
