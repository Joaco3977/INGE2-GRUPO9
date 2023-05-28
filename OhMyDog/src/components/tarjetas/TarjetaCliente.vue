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
            <q-expansion-item @click="loadPerrosCliente(dni)"
              expand-separator
              icon="ion-paw"
              label="Ver perros del cliente"
            >
              <q-card>
                <q-card-section>
                  <div class="column justify-center">
                    <q-btn v-for="perro in perrosCliente.value" :key="perro"
                      @click="verPerro = true; perroElegido = perro"
                      class="q-mx-lg q-mb-sm" 
                      color="secondary"
                    >
                      <div class="textoBoton text-bold"> {{ perro.NOMBRE }}</div>
                    </q-btn>
                    
                  </div>
                </q-card-section>

              </q-card>
            </q-expansion-item>
          </div>

          <div class="column col-3 justify-center content-end">
                  <q-btn class="textoBoton q-ml-lg" color="accent" @click="agregarPerro = true"> Agregar perro </q-btn>
          </div>
        </div>
      </q-card-section>
      <q-card-actions class="column items-center">
        <!-- <q-btn push class="textoBoton"  flat> Editar </q-btn> -->
      </q-card-actions>
    </q-card>

    <q-dialog  v-model="verPerro" >
      <TarjetaPerroVet :perro="perroElegido"/>
    </q-dialog> 

    <q-dialog v-model="confirmar">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary"> ¿Eliminar cliente? </div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          Esta acción no puede deshacerse
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Eliminar" @click="ejecutarFuncionPadre(dni)" color="primary" v-close-popup />
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog v-model="agregarPerro">
      <FormPerro @registrarPerro= "registrarPerro" />
    </q-dialog>

  </div>
</template>

<script>
import { api } from "src/boot/axios";
import { defineComponent } from "vue";
import { ref } from "vue";
import TarjetaPerroVet from "./TarjetaPerroVet.vue"
import FormPerro from "../formularios/formPerro.vue"

export default defineComponent({
  name: "TarjetaCliente",
  components: {
    TarjetaPerroVet,
    FormPerro,
  },
  props: {
    dni: String,
    nombreaApellido: String,
    mail: String,
    telefono: String,
    direccion: String,
  },
  setup(props) {
    const perrosCliente = ref([])

    const perroElegido = ref("");

    const registrarPerro = async (perroAdd) => {
      try {
        const response = await api.post("/perro/addPerro", {
          perro: {
            nombre:perroAdd.nombre,
            tamanio:perroAdd.tamanio,
            color:perroAdd.color,
            nacimiento:perroAdd.nacimiento,
            sexo:perroAdd.sexo,
            raza:perroAdd.raza,
            peso:perroAdd.peso,
            dnicliente: props.dni,
          },
        });
      } catch (error) {
        console.error(error);
      }
    };

    return {
      confirmar: ref(false),
      verPerro: ref(false),
      agregarPerro: ref(false),
      perrosCliente,
      perroElegido,
      registrarPerro,
    };
  },
  methods: {
    ejecutarFuncionPadre(dni) {
      this.$emit("ejecutarFuncion", dni);
    },
    async loadPerrosCliente(dni) {         //YA FUNCIONAL
      await api.post('/perro/getPerrosPropios', {
        dni: dni,
      })
      .then ((response) => {
        this.perrosCliente.value = response.data
        //console.log(response.data)
      })
      .catch((error) => {
        console.error(error)
      })
    }
  },
});
</script>
