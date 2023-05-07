import { defineStore } from "pinia";

export const useStore = defineStore("store", {
  state() {
    return {
      rol: 0,
      tab: "Quienes Somos",
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
