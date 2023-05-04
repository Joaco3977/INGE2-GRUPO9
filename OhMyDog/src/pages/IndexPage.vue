<template>
<div class= "row" style="height: 100vh; max-height: 100vh">
  <!-- Menú lateral -->
  <div class="col-2 bg-primary shadow-2" style="max-width: 35vh; height: 100vh">
    <q-img src="logotipo" />    
    
    <q-tabs 
        v-model="tab"
        inline-label
        vertical
        flat
        class=" q-py-sm bg-primary text-white  "
        style="max-height: 70vh"
      >
        <q-tab name="Mi Perfil" icon="ion-person"  label="Mi Perfil" />
        <q-tab name="Turnos" icon="ion-calendar"  label="Turnos" />
        <q-tab name="Mis Perros" icon="ion-paw" label="Mis Perros" />
        <q-tab name="Clientes" icon="ion-person" label="Clientes" />
        <q-tab name="Adopciones" icon="ion-heart" label="Adopciones" />
        <q-tab name="Paseadores" icon="ion-walk" label="Paseadores" />
    </q-tabs>
  </div>
  <!-- Secciones -->
  <div class="col-10 bg-secondary" >
    <q-tab-panels
          v-model="tab"
          animated
          swipeable
          vertical
          transition-prev="jump-up"
          transition-next="jump-up"
        >
          <q-tab-panel name="Mi Perfil">
            <PaginaPerfil />
          </q-tab-panel>
          
          <q-tab-panel name="Turnos">
            <PaginaTurnos />
          </q-tab-panel>

          <q-tab-panel name="Mis Perros">
            <PaginaPerros />
          </q-tab-panel>

          <q-tab-panel name="Clientes">
            <PaginaClientes />
          </q-tab-panel>

          <q-tab-panel name="Adopciones">
            <PaginaAdopciones />
          </q-tab-panel>

          <q-tab-panel name="Paseadores">
            <PaginaPaseadores />
          </q-tab-panel>

    </q-tab-panels>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { ref } from 'vue'
import PaginaTurnos from '../components/PaginaTurnos.vue'
import PaginaClientes from '../components/PaginaClientes.vue'
import PaginaPerros from '../components/PaginaPerros.vue'
import PaginaAdopciones from '../components/PaginaAdopciones.vue'
import PaginaPaseadores from '../components/PaginaPaseadores.vue'
import PaginaPerfil from '../components/PaginaPerfil.vue'

export default defineComponent({
  name: 'IndexPage',
  components: {
    PaginaTurnos,
    PaginaClientes,
    PaginaPerros,
    PaginaAdopciones,
    PaginaPaseadores, 
    PaginaPerfil,
  },
  setup () {
    return {
      tab: ref('Turnos'),
      splitterModel: ref(20)
    }
  }
})
</script>
