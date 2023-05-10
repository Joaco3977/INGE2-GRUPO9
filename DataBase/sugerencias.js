// VER LISTA DE "x" - POST segun "x" traer las entradas de la tabla de sugerencias correspondiente a "x"

if (this.store.rol == 1){
    response = await api.post("/cliente/getCliente", {
      mail: this.mail
    });
    this.store.setDni(response.data[0].DNI)
  }else
  if (this.store.rol == 2){
    response = await api.post("/veterinario/getVeterinario", {
      mail: this.mail
    });
    this.store.setDni(response.data[0].DNI)
  }