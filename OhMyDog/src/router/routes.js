const routes = [
  {
    path: "/",
    component: () => import("pages/IndexPage.vue"),
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue"),
  },
];

// ESTO VEREFICARIA EL TOKEN EN EL LOCALSTORAGE, EN CASO DE NO HABER SE VUELVE A SOLICITAR LOGIN
/*
router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !LocalStorage.getItem("token")) {
    rol.value = 0;
    next("/");
  } else {
    next();
  }
});
*/

export default routes;
