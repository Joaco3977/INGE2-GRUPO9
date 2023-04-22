import { createRouter, createWebHistory } from 'vue-router'

export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
        path: '/sobrenosotros',
        component: () => import ('./views/About.vue'),
    },
    {
        path: '/login',
        component: () => import ('./views/Login.vue'),
    },
    {
        path: '/servicios',
        component: () => import ('./views/Servicios.vue'),
    },
    {
        path: '/donar',
        component: () => import ('./views/Donar.vue'),
    },
    {
        path: '/contacto',
        component: () => import ('./views/Contacto.vue'),
    }
  ],
})

/*
    {
        path: '/admin',
        component: Admin,
        children: [
            {
              path: 'log',
              component: Log,
            },
            {
              path: 'admvets',
              component: AdmVets,
            },
          ],
    },
 */
