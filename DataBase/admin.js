 // VER LOG - GET traer todos las entradas

 // FILTRAR LOG - seria interno en JS, con el GET ya dado de arriba, puesto q no podemos filtrar por string en BD  Ó  con filtro Like en BD.

/*
si (es admin) {
    rol -1
    corto
} sino {
    si (es veterinario) {
        rol 2
        corto
    } sino {
        si (es cliente) {
            rol 1
            corto
        } sino {
            notificar las credenciales no son validas
        }
    }
}
*/

const knex = require("knex")({
    client: "mysql2",
    connection: {
      host: "localhost",
      user: "root",
      password: "cg7ThKa8Bd@r5zyi",
      database: "ohmydog",
    },
});

function checkAdmin (mail, pass) {
    if (mail == 'OhMyDog@admin.com' && pass == '357') {
        return true;
    } return false;
}

module.exports = { checkAdmin };