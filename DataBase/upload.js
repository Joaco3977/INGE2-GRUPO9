const multer = require('multer')
const storage = multer.diskStorage({
    destination: function(req,file,cb){
        cb(null,`imagenes/${req.body.seccion}`)
    },
    filename: function(req,file,cb){
        cb(null, `${req.body.id}.png`)
    }
})

const upload = multer({storage : storage})

exports.upload = upload.single("perroPerdidoImagen")
