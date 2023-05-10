<template>
  <div class="q-pa-md" style="width: 50rem">
    <div class="textoTituloTarjeta text-accent q-pt-md">HOLAAAAA</div>
    <q-form class="q-pa-md" @submit.prevent="registrarCliente">
      <q-input
        ref="inputRef"
        class="q-px-xl"
        label="DNI"
        v-model="clienteAgregarDni"
        maxlength="8"
        reactive-rules
        :rules="[
          (val) => !!val | 'Es necesario completar este campo',
          (val) => /^\d+$/.test(val) == true,
        ]"
      />
      <q-input
        class="q-px-xl"
        v-model="clienteAgregarNombreApellido"
        label="Nombre y Apellido"
        type="text"
        :rules="[(val) => !!val | 'Es necesario completar este campo']"
      />
      <!-- <q-input ref="inputRef" class="q-px-xl" v-model="clienteAgregarDni" label="DNI" 
                    type="number" mask="########" maxlenght='8' 
                    :rules="[
          val => !!val || '* Es necesario completar este campo',
          val => val.length < 8 || 'Formato de DNI incorrecto',
        ]" lazy-rules
        hint="Validation starts after first blur"
                  />  -->
      <!-- <q-input class="q-px-xl" v-model="clienteAgregarNombreApellido" label="Nombre y Apellido" type="text" />
                  <q-input class="q-px-xl" v-model="clienteAgregarMail" label="Correo electrónico" type="email" />
                  <q-input class="q-px-xl" v-model="clienteAgregarTelefono" label="Telefono" type="tel" mask="(###) ### - ####" />
                  <q-input class="q-px-xl" v-model="clienteAgregarDireccion" label="Direccion" type="text" />
                  <q-btn push class="q-mt-lg q-mx-xl" color="accent" type="submit" label="Registrar Cliente" /> -->
    </q-form>
  </div>
</template>

<script>
import { defineComponent, reactive, ref, watch } from "vue";
import { QDialog } from "quasar";

export default defineComponent({
  name: "agregarCliente",
  components: {
  },
  setup() {
    const inputRef = ref(null);

    const clientes = reactive([]);
    const clientesFiltrados = ref([]);
    const dniFiltrar = ref("");

    const clienteAgregarNombreApellido = ref("");
    const clienteAgregarMail = ref("");
    const clienteAgregarTelefono = ref("");
    const clienteAgregarDireccion = ref("");

    const registrarCliente = async () => {
      try {
        const response = await api.post("/cliente/addCliente", {
          token: LocalStorage.getItem("token"),
          cliente: {
            dni: clienteAgregarDni.value,
            nombreApellido: clienteAgregarNombreApellido.value,
            mail: clienteAgregarMail.value,
            telefono: clienteAgregarTelefono.value,
            direccion: clienteAgregarDireccion.value,
          },
        });
      } catch (error) {
        console.error(error);
      }
    };

    
    return {
      inputRef,
      registrarCliente,
    };
  },
});
</script>
