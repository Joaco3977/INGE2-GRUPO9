const express = require('express');
const cors = require('cors');
const app = express().use(express.json());
const mysql = require('mysql2');

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  next();
});

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

const corsOptions = {
  origin: 'http://localhost:5173',
  optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204 
}
app.use(cors(corsOptions));

app.get('/usuarios', function(req,res){
    console.log("alguien hizo peticion de clientes")
    connection.query('SELECT * FROM cliente', function(error, resultados, campos) {
        if (error) throw error;
        res.json(resultados);
      })
})

app.post('/intentoLogin', (req, res) => {
  console.log(req.body)
  //console.log(`Mail: ${mail}\nPassword:${password}`)
  res.send('OK')
})

app.listen(5137, function() {
  console.log('Servidor Back iniciado en el puerto 5137');
});
