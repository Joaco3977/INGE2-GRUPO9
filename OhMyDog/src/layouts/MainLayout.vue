<template>
  <q-layout view="lHh Lpr lFf">
<<<<<<< HEAD
  <!--    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
    >
      <q-list>
=======
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title> Menu </q-toolbar-title>
      </q-toolbar>
    </q-header>

    <q-drawer v-model="leftDrawerOpen" show-if-above bordered>
      <q-list>
        <q-item-label header> Menu </q-item-label>
>>>>>>> 2fcc9e89fe72fd86433f8a383c14214d5dac198f

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
<<<<<<< HEAD
import { defineComponent, ref } from 'vue'
//import MenuItem from 'components/MenuItem.vue'


const listaServicios = [
  {
    title: "Turnos",
    icon: "calendar",
    acciones: [
      {nombre: "Solicitar turno" },
      {nombre: "Ver turnos"},
    ]
  }
]
=======
import { defineComponent, ref } from "vue";
import EssentialLink from "components/EssentialLink.vue";
>>>>>>> 2fcc9e89fe72fd86433f8a383c14214d5dac198f

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
<<<<<<< HEAD
    //MenuItem
  },

  /* setup () {
    const leftDrawerOpen = ref(false)
=======
    EssentialLink,
  },

  setup() {
    const leftDrawerOpen = ref(false);
>>>>>>> 2fcc9e89fe72fd86433f8a383c14214d5dac198f

    return {
      servicios: listaServicios,
      essentialLinks: linksList,
      leftDrawerOpen,
<<<<<<< HEAD
      toggleLeftDrawer () {
        leftDrawerOpen.value = !leftDrawerOpen.value
      }
    }
  } */
})
=======
      toggleLeftDrawer() {
        leftDrawerOpen.value = !leftDrawerOpen.value;
      },
    };
  },
});
>>>>>>> 2fcc9e89fe72fd86433f8a383c14214d5dac198f
</script>
