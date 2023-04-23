const express = require('express');
const cors = require('cors');
const app = express();
const mysql = require('mysql2');

// Crea una conexión a la base de datos
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'cg7ThKa8Bd@r5zyi',
  database: 'ohmydog'
});

// Verifica si hay errores de conexión
connection.connect(function(error) {
  if (error) {
    console.error('Error al conectar a la base de datos: ' + error.stack);
    return;
  }
  console.log('Conexión a la base de datos establecida con éxito.');
});

app.use(cors());

app.get('/', function(req, res) {
    console.log("alguien hizo peticion")
  res.json({mensaje:'¡Hola, mundo!'});
});

app.get('/usuarios', function(req,res){
    console.log("alguien hizo peticion de clientes")
    connection.query('SELECT * FROM cliente', function(error, resultados, campos) {
        if (error) throw error;
        res.json(resultados);
      })
})

app.listen(5137, function() {
  console.log('Servidor web iniciado en el puerto 5137');
});
