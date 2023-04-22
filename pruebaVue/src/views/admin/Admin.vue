<template>
    <div>
        <h1>Menu de Administracion</h1>
        <router-link to="/admin/log">Ver Log</router-link>
        <br />
        <router-link to="/admin/admvets">Administrar Veterinarios</router-link>
        <router-view></router-view>
    </div>
</template>