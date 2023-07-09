<template>
  <div class="bg-white" style="width: full; max-height: 99vh">
    <div
      class="flex row q-mx-xl justify-between items-center"
      style="height: 4em"
    >
      <div class="titulo text-center text-h4 text-bold text-primary">
        VETERINARIAS DE TURNO
      </div>
      <q-btn
        @click="agregarVetDeTurno = true"
        color="accent"
        class=""
        style="width: max-content; height: max-content"
      >
        <div class="textoBoton">Agregar veterinaria al listado</div>
      </q-btn>
    </div>

    <q-card stretch flat class="bg-white full-width full-height column no-wrap">
      <q-tabs
        v-model="tab"
        dense
        class="text-grey q-pt-md full-width"
        active-color="primary"
        indicator-color="primary"
        align="justify"
        narrow-indicator
      >
        <q-tab
          @click="loadListadoVetsTurno"
          name="listadoVets"
          label="Listado de veterinarias de turno"
        />
        <q-tab
          @click="loadVetsTurno"
          name="vetsTurno"
          label="Veterinarias registradas"
        />
      </q-tabs>
      <q-separator></q-separator>
      <q-tab-panels v-model="tab" animated class="full-width">
        <q-tab-panel name="listadoVets">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="perrosCruza.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaCruza
              class="q-px-sm col-stretch"
              v-for="perro in perrosCruza"
              :key="perro.ID"
              :id="perro.ID"
              :rol="rol"
              :foto="perro.FOTO"
              :nombre="perro.NOMBRE"
              :nacimiento="perro.NACIMIENTO"
              :peso="perro.PESO"
              :tamanio="perro.TAMANIO"
              :sexo="perro.SEXO"
              :raza="perro.RAZA"
              :color="perro.COLOR"
              :dnicliente="perro.DNICLIENTE"
              linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡Todavía no tenemos otros perros en cruza!
          </div>
          </q-scroll-area>
        </q-tab-panel>

        <q-tab-panel v-if="rol > 0" name="vetsTurno" class="column">
          <q-scroll-area
          :thumb-style="thumbStyle"
          :bar-style="barStyle"
          style="height: 86vh"
          class="bg-white"
          >
          <div
            v-if="perrosRecomendados.length > 0"
            class="full-width row wrap justify-center"
          >
            <TarjetaCruza
              class="q-px-sm col-stretch"
              v-for="perro in perrosRecomendados"
              :key="perro.ID"
              :id="perro.ID"
              :rol="rol"
              :foto="perro.FOTO"
              :nombre="perro.NOMBRE"
              :nacimiento="perro.NACIMIENTO"
              :peso="perro.PESO"
              :tamanio="perro.TAMANIO"
              :sexo="perro.SEXO"
              :raza="perro.RAZA"
              :color="perro.COLOR"
              :dnicliente="perro.DNICLIENTE"
              linkImg="https://cdn.quasar.dev/img/parallax2.jpg"
            />
          </div>
          <div
          class="row textoNoItems justify-center full-height content-center q-pa-xl"
          v-else
          >
            ¡Todavía no tenemos ningun perro en cruza para tu perro!
          </div>
          </q-scroll-area>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>

    <q-dialog v-model="agregarPerroCruza">
      <q-card>
        <q-card-section>
          <div class="textoTituloTarjeta text-primary">Agregar perro de cruza</div>
        </q-card-section>

        <q-card-section class="q-pt-none" v-if="opcionPerros.length === 0">
          No quedan perros para cruzar
        </q-card-section>

        <q-select
            v-if="opcionPerros.length > 0"
            v-model="perroElegido"
            :options="opcionPerros"
            class="q-px-xl"
            label="Perro"
        />

        <q-card-actions align="right">
          <q-btn
            flat
            label="Confirmar"
            @click="registrarPerroCruza(perroElegido.value.ID, fechaCelo)"
            :disabled="!camposValidos"
            color="primary"
            v-close-popup
          />
          <q-btn flat label="Volver" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>
<script>
</script>
