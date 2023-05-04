<template>

<q-expansion-item
    expand-separator
    :icon="icon"
    :label="title"
>
    <div class="q-pa-sm">
        <q-btn flat> 
            dskañdsakda } </q-btn>
    </div>
</q-expansion-item>
</template>



<script>

import { defineComponent } from 'vue'

export default defineComponent({
name: 'MenuItem',
props: {
   title: {
      type: String,
      required: true
    },
    icon: {
        type: String,
        required: true
    },
    acciones: {
        type: String,
        required: true
    }
}
})
</script>
