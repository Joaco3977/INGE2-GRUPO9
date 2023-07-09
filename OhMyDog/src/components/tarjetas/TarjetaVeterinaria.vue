<template>
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card class="my-card bg-primary text-white q-ma-md" style="width: 70vw">
      <q-card-section>
        <div class="column">
          <div class="q-pb-sm flex justify-end">
            <q-btn v-if="rol == 2" @click="confirmar = true" class="q-ml-sm" color="accent">
              <div>Eliminar</div>
            </q-btn>
            <q-btn v-if="rol == 2"  @click="mostrarPop = true" class="q-ml-sm" color="accent">
              <div>Editar</div>
            </q-btn>
          </div>
          <div class="row" v-if="tab === 'listadoVets'">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">FECHA: </div>
            <div>{{ (new Date(fecha)).toLocaleDateString() }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">NOMBRE:</div>
            <div>{{ nombre }}</div>
          </div>
          <div class="row">
            <div class="textoTituloPosteo q-pr-sm q-pb-xs">DIRECCION:</div>
            <div>{{ direccion }}</div>
          </div>
        </div>
      </q-card-section>
      <q-card-actions class="column items-center">

        <q-dialog v-model="confirmar">
          <q-card>
            <q-card-section>
              <div class="textoTituloTarjeta text-primary">
                ¿Eliminar veterinaria?
              </div>
            </q-card-section>

            <q-card-section class="q-pt-none">
              Esta acción no puede deshacerse
            </q-card-section>

            <q-card-actions align="right">
                            <q-btn flat label="Cancelar" color="primary" v-close-popup />

              <q-btn
                flat
                label="Eliminar"
                @click="eliminarVetTurno(id)"
                color="primary"
                v-close-popup
              />
            </q-card-actions>
          </q-card>
        </q-dialog>
      </q-card-actions>
    </q-card>
    <q-dialog v-model="mostrarPop">
      <formVeterinaria
        @editarVeterinaria="editarVeterinaria"
        :id="id"
        :nombre="nombre"
        :direccion="direccion"
        :nombresVeterinarias="nombresVeterinarias"
      />
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";
import formVeterinaria from "../formulariosEditar/formVeterinaria.vue";
import { api } from "../../boot/axios.js";
import { useStore } from "../../pinia/store.js";

export default defineComponent({
  name: "TarjetaVeterinaria",
  components: { formVeterinaria },
  props: {
    id: String,
    tab: String,
    nombre: String,
    direccion: String,
    fecha: String,
    nombresVeterinarias: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const mostrarPop = ref(false);
    const rol = useStore().rol;
    return {
      confirmar: ref(false),
      mostrarPop,
      rol,
    };
  },
  methods: {
    eliminarVetTurno(id) {
      const data = {
        id: id,
        tab: this.tab,
      }
      this.$emit("eliminarVetTurno", data);
    },
    async editarVeterinaria(veterinaria) {
      try {
        const response = await api.post("/vetsTurno/editarVeterinaria", {
          veterinario: {
            dni: veterinario.dni,
            nombreApellido: veterinario.nombreApellido,
            mail: veterinario.mail,
            telefono: veterinario.telefono,
            dniA: veterinario.dniA,
          },
        });
        this.mostrarPop = false;
        await this.$emit("loadVeterinarios");
      } catch (error) {
        console.error(error);
      }
    },
  },
});
</script>
