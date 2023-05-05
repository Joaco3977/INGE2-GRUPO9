<template>
  <q-layout view="lHh Lpr lFf">
    <!--    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
    >
      <q-list>

        <q-img
          src="https://picsum.photos/500/300"
          :ratio="16/9"
        />

        <MenuItem 
          v-for= "servicio in servicios"
          :key="servicio.title"
          v-bind="servicio"
        />
        
      </q-list>
    </q-drawer> -->

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent, ref } from "vue";
//import MenuItem from 'components/MenuItem.vue'

const listaServicios = [
  {
    title: "Turnos",
    icon: "calendar",
    acciones: [{ nombre: "Solicitar turno" }, { nombre: "Ver turnos" }],
  },
];

const linksList = [
  {
    title: "Sobre nosotros",
    caption: "quasar.dev",
    icon: "info",
    link: "https://quasar.dev",
  },
  {
    title: "Iniciar Sesion",
    caption: "github.com/quasarframework",
    icon: "login",
    link: "https://github.com/quasarframework",
  },
  {
    title: "Servicios",
    caption: "chat.quasar.dev",
    icon: "medical_information",
    link: "https://chat.quasar.dev",
  },
  {
    title: "Donar",
    caption: "forum.quasar.dev",
    icon: "paid",
    link: "https://forum.quasar.dev",
  },
  {
    title: "Contacto",
    caption: "@quasarframework",
    icon: "phone",
    link: "https://twitter.quasar.dev",
  },
];

export default defineComponent({
  name: "MainLayout",

  components: {
    //MenuItem
  },

  /* setup () {
    const leftDrawerOpen = ref(false)

    return {
      servicios: listaServicios,
      essentialLinks: linksList,
      leftDrawerOpen,
      toggleLeftDrawer () {
        leftDrawerOpen.value = !leftDrawerOpen.value
      }
    }
  } */
});
</script>
