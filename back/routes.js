const connection = require('./database/connection')
const express = require('express')
const router = express.Router()
const AtividadeController = require('./controllers/atividade-controller')
const UsuarioController = require('./controllers/usuario-controller')

router.get('/usuarios', (req, res) => {
    connection.query('SELECT * FROM opt120.Usuario', (err, results) => {
      if (err) throw err;
      res.json(results);
      console.log(res)
    });
  });

router.post('/novaTarefa',AtividadeController.newActivity)

router.get('/showAtv', AtividadeController.showActivity)
router.get('/showUser', UsuarioController.showUser)


module.exports = router