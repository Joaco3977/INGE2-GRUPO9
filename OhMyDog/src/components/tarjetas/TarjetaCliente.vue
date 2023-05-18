<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <q-card class="my-card bg-white text-white q-ma-md" style="width: 75vw">
      <q-card-section class="bg-primary">
        <div class="row justify-between full-width">
          <!-- <q-btn
            class=""
            color="accent"
          >
            <div>Editar datos</div>
          </q-btn> -->
          <div class="textoPerfil q-pl-md">
            {{ nombreaApellido }}
          </div>
          <q-btn @click="confirmar = true" class="q-ml-sm" color="accent">
            <div>Eliminar</div>

            <!-- @click="ejecutarFuncionPadre(dni)"-->
          </q-btn>
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
              <div>{{ nombreaApellido }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Mail:</div>
              <div>{{ mail }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Telefono:</div>
              <div>{{ telefono }}</div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs">Direccion:</div>
              <div>{{ direccion }}</div>
            </div>
          </div>
          
          <div class="column col-5">
            <q-expansion-item
              expand-separator
              icon="ion-paw"
              label="Ver perros del cliente"
            >
              <q-card>
                <q-card-section>
                  <div class="column justify-center">
                    <q-btn
                      @click="confirmar = true"
                      class="q-mx-lg"
                      color="secondary"
                    >
                      <div class="textoBoton text-bold">Mike Wasowski</div>
                    </q-btn>
                  </div>
                </q-card-section>
                
              </q-card>
            </q-expansion-item>
          </div>

          <div class="column col-3 justify-center content-end">
                  <q-btn class="textoBoton q-ml-lg" color="accent"> Agregar perro </q-btn>
          </div>
        </div>
      </q-card-section>
      <q-card-actions class="column items-center">
        <!-- <q-btn push class="textoBoton"  flat> Editar </q-btn> -->
      </q-card-actions>
    </q-card>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "TarjetaCliente",
  components: {},
  props: {
    dni: String,
    nombreaApellido: String,
    mail: String,
    telefono: String,
    direccion: String,
  },
  setup() {
    return {};
  },
  methods: {
    ejecutarFuncionPadre(dni) {
      this.$emit("ejecutarFuncion", dni);
    },
  },
});
</script>
