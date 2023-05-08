import { boot } from "quasar/wrappers";
import axios from "axios";

const api = axios.create({ baseURL: "http://190.191.175.12:5137" });

export default boot(({ app }) => {
  app.config.globalProperties.$axios = axios;
  app.config.globalProperties.$api = api;
});

export { api };
