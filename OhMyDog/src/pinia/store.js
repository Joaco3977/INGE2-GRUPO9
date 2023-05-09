import { defineStore } from "pinia";

export const useStore = defineStore("store", {
  state() {
    return {
      rol: 0,
      tab: "Quienes Somos",
      dni: 44,
    };
  },
  actions: {
    setRol(nuevoValor) {
      this.rol = nuevoValor;
    },
    setTab(nuevoValor) {
      this.tab = nuevoValor;
    },
    setDni(nuevoValor) {
      this.dni = nuevoValor;
    }
  },
});
