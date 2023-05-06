import { defineStore } from "pinia";

export const useStore = defineStore("store", {
  state() {
    return {
      rol: 0,
    };
  },
  actions: {
    setRol(nuevoValor) {
      this.rol = nuevoValor;
    },
  },
});
