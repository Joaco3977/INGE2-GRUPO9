import { LocalStorage } from "quasar";
import { useStore } from "../pinia/store.js";
import { api } from "../boot/axios.js"

export const checkToken = async () => {
  const store = useStore();
  if (LocalStorage.getItem("token") !== undefined) {
    try {
      const response = await api.post("/checkToken", {
        token: LocalStorage.getItem('token'),
      });
      store.setRol(response.data.rol);
      if (response.data.rol === 0) {
        store.setRol(0);
        store.setDni(0);
        store.setTab('Iniciar Sesion')
        return false;
      } else {
        store.setDni(response.data.dni)
        return true
      }
    } catch (error) {
      console.error(error);
      store.setRol(0);
      store.setDni(0);
      store.setTab('Iniciar Sesion');
      return false;
    }
  } else {
    store.setRol(0);
    store.setDni(0);
    store.setTab('Iniciar Sesion');
    return false;
  }
};

export const checkTokenHome = async () => {
  const store = useStore();
  if (LocalStorage.getItem("token") !== undefined) {
    try {
      const response = await api.post("/checkToken", {
        token: LocalStorage.getItem('token'),
      });
      store.setRol(response.data.rol);
      if (response.data.rol === 0) {
        store.setTab('Quienes Somos')
        return false;
      } else {
        store.setDni(response.data.dni)
        return true
      }
    } catch (error) {
      console.error(error);
      store.setRol(0);
      store.setDni(0);
      store.setTab('Quienes Somos');
      return false;
    }
  } else {
    store.setRol(0);
    store.setDni(0);
    store.setTab('Quienes Somos');
    return false;
  }
};
