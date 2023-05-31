<template>
    <!-- Todo el contenido tiene que estar adentro de un div -->
    <!-- Pueden usar componentes dentro de este componente -->
    <div class="bg-white" style="width: full; max-height: 90vh">
      <q-card class="my-card bg-primary text-white q-ma-md" style="width: 22vw">
        <q-img
          src="https://media.sketchfab.com/models/060d500bf27a4b9ab242ea67d1baad76/thumbnails/a55c7d7c89ff4725b76be6eb3fe3f1f2/9f9a4b4fba9e40838d0acb8e34773196.jpeg"
        ></q-img>
        <q-card-section>
          <!-- Contenido -->
          <div class="column">
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> DNI:</div>
              <div>  {{dni}} </div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Nombre y Apellido:</div>
              <div> {{nombreaApellido}} </div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Mail:</div>
              <div> {{mail}} </div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Telefono:</div>
              <div>  {{telefono}} </div>
            </div>
          </div>
        </q-card-section>
        <q-card-actions class="column items-center">
          <!--<q-btn push class="textoBoton"  flat> Contactar </q-btn>
          <q-btn push class="textoBoton"  flat> Editar </q-btn>-->
          <q-btn @click="confirmar = true" class="q-ml-sm" color="accent">
            <div>Eliminar</div>

            <!-- @click="ejecutarFuncionPadre(dni)"-->
          </q-btn>
            <q-dialog v-model="confirmar">
              <q-card>
                <q-card-section>
                  <div class="textoTituloTarjeta text-primary">¿Eliminar veterinario?</div>
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
        </q-card-actions>
      </q-card>
    </div>
  </template>
  
  <script>
  import { defineComponent } from "vue";
  import { ref } from "vue";
  
  export default defineComponent({
    name: "TarjetaVeterinario",
    components: {},
    props: {
      dni: String,
      nombreaApellido: String,
      mail: String,
      telefono: String,
    },
    setup() {
      return {
        confirmar: ref(false)
      };
    },
    methods: {
      ejecutarFuncionPadre(dni) {
        this.$emit('ejecutarFuncion', dni);
      }
    }
  });
  </script>