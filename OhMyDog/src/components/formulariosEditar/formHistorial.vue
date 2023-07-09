<template>
    <div class="flex">
      <q-card style="width: 40rem">
        <q-card-section class="bg-secondary">
          <div class="text-h5 text-uppercase text-white text-center text-bold">
            Editar Historial
          </div>
        </q-card-section>
        <q-card-section class="">
          <q-form class="q-px-xl" reset>
            <q-select
              v-model="nombreServicio"
              :options="opcionServicio"
              class="q-px-xl"
              label="Servicio"
            />
            <q-select
              v-if="nombreServicio === 'Vacunación'"
              v-model="nombreVacuna"
              :options="opcionVacuna"
              class="q-px-xl"
              label="Vacuna"
            />
            <q-input
              class="q-pa-lg"
              v-model="comentario"
              clearable
              filled
              placeholder="Notas"
              type="textarea"
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
            <div class="row justify-end q-pt-xl">
              <q-btn
                label="Cancelar"
                type="reset"
                color="primary"
                flat
                class="q-ml-sm"
                v-close-popup
              />
              <q-btn :disabled="!camposValidos" @click="confirmar = true" label="Editar Historial" color="accent" />
            </div>
          </q-form>
        </q-card-section>
      </q-card>

      <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">¿Editar Entrada?</div>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />

          <q-btn
            flat
            label="Confirmar"
            @click="editarEntrada()"
            color="primary"
            v-close-popup
          />
        </q-card-actions>
      </q-card>
    </q-dialog>
    </div>
  </template>
  
  <script>
  import { defineComponent, ref } from "vue";
  import { useStore } from "src/pinia/store";
  
  export default defineComponent({
    name: "formHistorial",
    props: {
      id:String,
      fecha:String,
      Aservicio:String,
      Acomentario:String,
      AnombreVacuna:String,
    },
    setup(props, { emit }) {

      const nombreServicio = ref (props.Aservicio)
      const nombreVacuna = ref (props.AnombreVacuna)
      const comentario = ref (props.Acomentario)
      
      const comprobarFecha = ()=>{
        var fechaInicial = new Date(props.fecha);
        var fechaActual = new Date();
        var milisegundosPorDia = 24 * 60 * 60 * 1000; // Cantidad de milisegundos en un día
        var diferenciaEnMilisegundos = fechaActual - fechaInicial;
        var diasTranscurridos = Math.floor(diferenciaEnMilisegundos / milisegundosPorDia);
        return diasTranscurridos <= 1;
      }

      const editarEntrada = async () => {
        let entrada;
        if (nombreVacuna.value == null){
          entrada = {
          ID:props.id,
          NOMBRESERVICIO: nombreServicio.value.value,
          COMENTARIO: comentario.value,
          NOMBREVACUNA: null,
        }
        }else{
          entrada = {
          ID:props.id,
          NOMBRESERVICIO: nombreServicio.value.value,
          COMENTARIO: comentario.value,
          NOMBREVACUNA: nombreVacuna.value.value,
        }
        }
        emit('editarHistorial', entrada);
      }
  
      return {
        confirmar: ref(false),
        nombreServicio,
        nombreVacuna,
        comentario,
        editarEntrada,
        comprobarFecha,
        opcionServicio: [
          { label: "Consulta", value: "Consulta" },
          { label: "Vacunación", value: "Vacunación" },
          { label: "Desparacitación", value: "Desparacitación" },
          { label: "Castración", value: "Castración" },
        ],
        opcionVacuna: [
          { label: "Rabia", value: "Rabia" },
          { label: "Parvovirus canino", value: "Parvovirus canino" },
          { label: "Moquillo", value: "Moquillo" },
          { label: "Hepatitis canina", value: "Hepatitis canina" },
        ],
      }
    },
    methods: {
  
    },
    computed: {
      mensajeError(){
        let sError = [];
        if (!this.comprobarFecha() ){
          sError.push( "Ya pasaron las 24hs para editar esta entrada" )
        }
      return sError
      },
      camposValidos () {
        return this.nombreServicio !== null && this.comprobarFecha()
      }
    },
  });
  </script>