import { boot } from "quasar/wrappers";
import axios from "axios";

const api = axios.create({ baseURL: "http://190.191.175.12:5137" });

api.interceptors.request.use((config) => {
  /*
  ESTO SE EJECUTA CADA VEZ Q HAGO UNA PETICION CON AXIOS DESDE EL FRONT
  OBTIENE EL TOKEN Y LO MANDA EN req.headers.authorization
  */
  const token = localStorage.getItem("token");
  if (token) {
    config.headers.Authorization = token;
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

export default boot(({ app }) => {
  app.config.globalProperties.$axios = axios;
  app.config.globalProperties.$api = api;
});

export { api };

/* hola esto es un comentario para ver si se actualiza */