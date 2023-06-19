<template>
    <!-- Todo el contenido tiene que estar adentro de un div -->
    <!-- Pueden usar componentes dentro de este componente -->
    <div class="bg-white" style="width: full; max-height: 90vh">
      <q-card class="my-card bg-primary text-white q-ma-md" style="width: 70vw">
        <q-card-section>
          <!-- Contenido -->
          <div class="column">
            <div class="q-pb-sm flex justify-end">
              <q-btn @click="confirmar = true" class="q-ml-sm" color="accent">
                <div>Eliminar</div>
            <!-- @click="ejecutarFuncionPadre(dni)"-->
              </q-btn>
              <q-btn @click="mostrarPop = true" class="q-ml-sm" color="accent">
                <div>Editar</div>
              </q-btn>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> DNI:</div>
              <div>  {{dni}} </div>
            </div>
            <div class="row">
              <div class="textoTituloPosteo q-pr-sm q-pb-xs"> Nombre y Apellido:</div>
              <div> {{nombreApellido}} </div>
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
      <q-dialog v-model="mostrarPop">
      <formVeterinario
        @editarVeterinario="editarVeterinario"
        :dni="dni"
        :nombreApellido="nombreApellido"
        :mail="mail"
        :telefono="telefono"
        :mailsClientes="mailsClientes"
        :mailsVeterinarios="mailsVeterinarios"
        :dniClientes="dniClientes"
        :dniVeterinarios="dniVeterinarios"
      />
    </q-dialog>
    </div>
  </template>
  
  <script>
  import { defineComponent } from "vue";
  import { ref } from "vue";
  import formVeterinario from "../formulariosEditar/formVeterinario.vue";
  import { api } from "../../boot/axios.js";
  
  export default defineComponent({
    name: "TarjetaVeterinario",
    components: { formVeterinario },
    props: {
      dni: String,
      nombreApellido: String,
      mail: String,
      telefono: String,
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
      dniVeterinarios: {
        type: Array,
        required: true,
      },
    },
    setup() {
      return {
        confirmar: ref(false),
        mostrarPop: ref(false),
      };
    },
    methods: {
      ejecutarFuncionPadre(dni) {
        this.$emit('ejecutarFuncion', dni);
      },
      async editarVeterinario(veterinario){
        try {
        const response = await api.post("/veterinario/editarVeterinario",{
          veterinario: {
            dni: veterinario.dni,
            nombreApellido: veterinario.nombreApellido,
            mail: veterinario.mail,
            telefono: veterinario.telefono,
            dniA: veterinario.dniA,
          },
        });
        await this.$emit('loadVeterinarios');
      } catch (error) {
        console.error(error);
      }
      }
    }
  });
  </script>