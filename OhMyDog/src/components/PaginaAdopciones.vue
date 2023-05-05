<template>
  <!-- Todo el contenido tiene que estar adentro de un div -->
  <!-- Pueden usar componentes dentro de este componente -->
  <div class="bg-white" style="width: full; max-height: 90vh">
    <div class="text-center text-h4 text-primary">ADOPCIONES</div>
    <div class="text-center text-h6 text-primary">
      Hola! Soy el componente "Página Adopciones" EDITAME
    </div>

    <q-scroll-area
      :thumb-style="thumbStyle"
      :bar-style="barStyle"
      style="height: 80vh"
      class="bg-white"
    >
      <!-- ACÁ VAN TODAS LAS COSAS QUE QUIERAN PONER -->

      <!-- -->

      <q-card flat>
        <q-tabs
          v-model="tab"
          dense
          class="text-grey"
          active-color="primary"
          indicator-color="primary"
          align="justify"
          narrow-indicator
        >
          <q-tab name="perrosOtros" label="¡Adoptá un perro!" />
          <q-tab name="perrosPropios" label="Mis perros en adopción" />
        </q-tabs>

        <q-separator />

        <q-tab-panels v-model="tab" animated>
          <q-tab-panel name="perrosOtros">
            Lorem ipsum dolor sit amet consectetur adipisicing elit.

            <div class="full-width column items-center">
              <q-card class="my-card bg-secondary text-white">
                <q-img src="https://media.sketchfab.com/models/060d500bf27a4b9ab242ea67d1baad76/thumbnails/a55c7d7c89ff4725b76be6eb3fe3f1f2/9f9a4b4fba9e40838d0acb8e34773196.jpeg"></q-img>
                <q-card-section>
                  <div>
                    - Nombre: Nombre <br/>
                    - Raza: raza   <br/>
                    - Tamanio: tamaño
                  </div>
                </q-card-section>
                <q-separator dark />
                <q-card-actions>
                  <q-btn flat> ¡Adoptado! </q-btn>
                  <q-btn flat> Eliminar perro</q-btn>
                </q-card-actions>
              </q-card>
            </div>
          </q-tab-panel>

          <q-tab-panel name="perrosPropios" style="height: full">
            <div class="full-width column items-center">
              <q-btn color="accent" class="q-ma-md" style="width: 25em">
                <q-icon left size="3em" name="ion-heart-empty" />
                <div class="textoBoton">¡Poné un perro en adopción!</div>
              </q-btn>
            </div>
          </q-tab-panel>
        </q-tab-panels>
      </q-card>
      <!-- -->

      <!-- los veterinarios tendrían una vista, los clientes otras Y LOS VISITANTES OTRAS??

      ahora estoy pensando en texto...
      - visitante: ver
      - cliente: ver, subir, ver subidos ( nota: usar dos columnas )
      - vet: ver editar -->

      <!-- Hasta acá :)  -->
    </q-scroll-area>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: "PaginaAdopciones",
  components: {},
  setup() {
    return {
      tab: ref("mails"),
    };
  },
});
</script>
