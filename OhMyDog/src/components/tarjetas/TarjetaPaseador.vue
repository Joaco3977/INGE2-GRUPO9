<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 97vh">
    <q-card
      flat
      class="my-card bg-primary text-white q-ma-md "
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
          <div class="column col-6 justify-start q-pl-sm">
            <div class="row items-baseline q-pb-sm ">
              <q-icon name="ion-walk" size="2rem" />
              <div class="textoComillas q-pb-md">{{ nombre }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-sm">
                Zona de trabajo:
              </div>
              <div>{{ zona }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Mail:</div>
              <div>{{ mail }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Teléfono:</div>
              <div>{{ telefono }}</div>
            </div>
            <div
              v-if="comentario != null && comentario.length > 0"
              class="bg-info q-mt-md q-mr-lg q-pa-md"
            >
              <div class="row">
                <div class="textoTituloPosteo q-mr-md q-pb-xs">
                  Información adicional
                </div>
                <div>{{ comentario }}</div>
              </div>
            </div>
            <!-- Acciones -->
            <div class="col-grow"></div>
            <q-card-actions class="column">
              <q-separator dark />

              <q-btn
                flat
                class="textoBoton"
                :href="convertirContacto()"
                target="_blank"
              >
                Contactar paseador
              </q-btn>
            </q-card-actions>
          </div>
          <div class="column col-6 q-pr-lg">
            <div
              class="text-bold row no-wrap full-width justify-around items-center q-py-sm"
            >
              <div class="text-white text-start" style="width: 5em">Día</div>
              <div class="text-end">Mañana</div>
              <div class="text-end">Tarde</div>
              <div class="text-end">Noche</div>
            </div>
            <div
              v-for="i in 7"
              :key="i"
              class="separadorFormulario row no-wrap full-width justify-between items-center q-py-xs q-pr-md"
            >
              <div class="text-white text-start" style="width: 5rem">
                {{ semana[i-1] }}
              </div>
              <q-icon v-if="disponibilidad[i-1][0] == true " class="q-py-xs" name="ion-checkmark" size="1.3rem" />
              <q-icon v-else class="q-py-xs" name="ion-close" size="1.3rem" />
              <q-icon v-if="disponibilidad[i-1][1] == true " class="q-py-xs" name="ion-checkmark" size="1.3rem" />
              <q-icon v-else class="q-py-xs" name="ion-close" size="1.3rem" />
              <q-icon v-if="disponibilidad[i-1][2] == true " class="q-py-xs" name="ion-checkmark" size="1.3rem" />
              <q-icon v-else class="q-py-xs" name="ion-close" size="1.3rem" />
            </div>
            <div class="row no-wrap q-py-md">
              <q-icon class="q-pr-sm" name="ion-information-circle-outline" size="1.4rem" />
              <div> Definir los horarios con el paseador</div>
            </div>
          </div>
        </div>
      </q-card-section>
    </q-card>

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Eliminar paseador?</div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Eliminar"
            @click="ejecutarFuncionPadre(dni)"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import { api } from "../../boot/axios.js";
import { useStore } from "../../pinia/store.js";

const semana = [
  "Lunes",
  "Martes",
  "Miércoles",
  "Jueves",
  "Viernes",
  "Sábado",
  "Domingo",
];

export default defineComponent({
  name: "TarjetaPaseador",
  components: {},
  props: {
    rol: String,
    dni: String,
    nombre: String,
    zona: String,
    disponibilidad: String,
    mail: String,
    comentario: String,
  },
  setup() {
    return {
      confirmar: ref(false),
      semana,
    };
  },
  methods: {
    stringToJSON() {
      return JSON.parse(this.disponibilidad);
    },

    convertirContacto() {
      let cont = "";
      if (this.mail.includes("@")) {
        cont =
          "mailto:" +
          this.mail +
          "?subject=Contacto%20desde%20OhMyDog%20-%20Paseo%20de%20perro";
      } else {
        cont =
          "https://api.whatsapp.com/send?phone=" +
          this.mail +
          "&text=Contacto%20desde%20OhMyDog%20por%20paseador20de%20perro";
      }
      return cont;
    },
    ejecutarFuncionPadre(dni) {
      this.$emit("ejecutarFuncion", dni);
    },
  },
  mounted(){
  }
});
</script>
