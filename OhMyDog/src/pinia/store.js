import { defineStore } from "pinia";

export const useStore = defineStore("store", {
  state() {
    return {
      rol: 0,
      tab: "Quienes Somos",
      dirBD: 'http://localhost:5137',
    };
  },
  actions: {
    setRol(nuevoValor) {
      this.rol = nuevoValor;
    },
    setTab(nuevoValor) {
      this.tab = nuevoValor;
    },
  },
});
