const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');

const ruta = path.resolve(__dirname, '/fotosPerros'); // Ruta absoluta para la carpeta de destino

const upload = multer({
  storage: multer.diskStorage({
    destination: ruta,
    filename: (req, file, cb) => {
      const nombreImagen = req.body.nombreImagen;
      const nombreArchivo = `${nombreImagen}${path.extname(file.originalname)}`;
      cb(null, nombreArchivo);
    },
  }),
});

router.post('/perroFoto', upload.single('imagen'), (req, res) => {
  console.log('File: ', req.file)
  res.status(200).send('Imagen cargada exitosamente');
});

module.exports = router;