<template>
  <div class="flex">
    <q-card style="width: 40rem">
      <q-card-section class="bg-secondary">
        <div class="text-h5 text-uppercase text-white text-center text-bold">
          Agregar perro perdido
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
            <div class="q-px-xl q-py-sm text-start self-start color-grey">
              Fecha de pérdida:
            </div>
            <q-date v-model="perroFECHA" minimal :options="opcionesFecha" />
          </div>
          <div class="column items-center bg-white q-pa-sm">
            <q-uploader
              v-model="imagenElegida"
              ref="uploaderPerdido"
              label= "Foto del perro"
              accept="image/*"
              :field-name="'perroPerdidoImagen'"
              :form-fields="[
                {name: 'seccion', value: 'PERDIDA'},
                {name: 'id', value: 0}
              ]"
              url="http://localhost:5137/perroPerdido/subirImagenPerdido"
              style="max-width: 300px"

              @added="imagenElegida = true"
              @removed="imagenElegida = false"
            />
          </div>
          <q-input
            v-model="perroZONA"
            class="q-px-xl"
            label="Zona de pérdida"
            type="text"
          />
          <q-input
            v-model="perroTELEFONO"
            class="q-px-xl"
            label="Teléfono de contacto"
          />
          <q-select
            v-model="perroSEXO"
            :options="opcionSexo"
            class="q-px-xl"
            label="Sexo"
          />

          <q-input
            v-model="perroCOMENTARIO"
            class="q-px-xl"
            label="Comentarios"
            type="text"
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
              label="Registrar Pérdida"
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
import { LocalStorage, useQuasar } from "quasar";
import { api } from "../../boot/axios.js";

export default defineComponent({
  name: "formAdopcion",
  setup() {
    const $q = useQuasar();

    const perroSEXO = ref("");
    const perroNOMBRE = ref("");
    const perroFECHA = ref("");
    const perroTELEFONO = ref("");
    const perroZONA = ref("");
    const perroCOMENTARIO = ref("");
    const perroDNICLIENTE = useStore().dni;
    const getDatosAdopcion = () => {
      const perro = {
        sexo: perroSEXO.value.value,
        zona: perroZONA.value,
        nombre: perroNOMBRE.value,
        telefono: perroTELEFONO.value,
        fechaPerdida: perroFECHA.value,
        mail: LocalStorage.getItem('mail'),
        comentario: perroCOMENTARIO.value,
        dnicliente: perroDNICLIENTE,
      };
      return perro;
    };

    const onReset = () => {
      perroSEXO.value = "";
      perroNOMBRE.value = "";
      perroTELEFONO.value = "";
      perroCOMENTARIO.value = "";
      perroZONA.value = "";
      perroFECHA.value = "";
      return false;
    };

    const opcionesFecha = (date) => {
      const hoy = new Date().toLocaleDateString("zh-Hans-CN", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
      });

      const fechaHace25Anios = new Date();
      fechaHace25Anios.setFullYear(fechaHace25Anios.getFullYear() - 1);
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
      opcionesFecha,
      perroSEXO,
      perroZONA,
      perroNOMBRE,
      perroTELEFONO,
      perroFECHA,
      perroCOMENTARIO,
      perroDNICLIENTE,
      opcionSexo: [
        { label: "Macho", value: "Macho" },
        { label: "Hembra", value: "Hembra" },
      ],
      getDatosAdopcion,
      onReset,
      imagenElegida,
    };
  },
  methods: {
    async ejecutarFuncionPadre() {
      const perro = this.getDatosAdopcion();
      await api.post("/perroPerdido/addPerroPerdido", {
          perro,
          rol: useStore().rol,
          dni: useStore().dni,
          nombre: useStore().nombre,
        }).then((result)=>{
          this.$refs.uploaderPerdido.formFields[1].value = result.data.id
          this.$refs.uploaderPerdido.upload();
          this.$emit("registrarPerro", perro);
        })
        .catch((error)=>{
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
      if (!this.fechaValida) {
        sError.push("Ingrese una fecha de pérdida");
      }
      if (!this.zonaValida) {
        sError.push("Ingrese una zona de pérdida");
      }
      if (!this.sexoValido) {
        sError.push("Seleccione un sexo");
      }
      if (!this.telefonoValido) {
        sError.push("Ingrese un teléfono válido");
      }
      if(!this.imagenSeleccionada) {
        sError.push("Se debe subir una foto");
      }
      return sError;
    },
    nombreValido() {
      return (
        this.perroNOMBRE.length > 0 && /^[A-Za-zÀ-ÿ\s]+$/.test(this.perroNOMBRE)
      );
    },
    zonaValida() {
      return this.perroZONA.length > 0;
    },
    telefonoValido() {
      return this.perroTELEFONO.length > 6 && /^\d+$/.test(this.perroTELEFONO);
    },
    fechaValida() {
      return this.perroFECHA.length > 0;
    },
    sexoValido() {
      return this.perroSEXO.value != undefined;
    },
    imagenSeleccionada () {
      return this.imagenElegida
    },
    camposValidos() {
      return (
        this.nombreValido &&
        this.zonaValida &&
        this.sexoValido &&
        this.telefonoValido &&
        this.fechaValida &&
        this.imagenSeleccionada
      );
    },
  },
});
</script>
