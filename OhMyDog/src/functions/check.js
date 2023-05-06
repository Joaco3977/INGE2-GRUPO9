import { LocalStorage } from "quasar";
import { useStore } from "../pinia/store.js";

const store = useStore();

export const checkToken = () => {
  if (LocalStorage.getItem("token") !== undefined) {
    //consulta por token
    //reasignar rol
    //en caso de ser necesario reseteamos localstorage y setrol = 0
    console.log("checkee token");
    //store.setRol(1);
  } else {
    store.setRol(0);
  }
};
