const connection = require('./database/connection')
const express = require('express')
const router = express.Router()
const AtividadeController = require('./controllers/atividade-controller')
const UsuarioController = require('./controllers/usuario-controller')
const usuarioAtividadeController = require('./controllers/usuario-atividade-controller')

/*router.get('/usuarios', (req, res) => {
    connection.query('SELECT * FROM opt120.Usuario', (err, results) => {
      if (err) throw err;
      res.json(results);
      console.log(res)
    });
  });*/

router.post('/newAtv',AtividadeController.newActivity)
router.post('/newUser',UsuarioController.newUser)
router.post('/newUserAtv', usuarioAtividadeController.newUserActivity)


router.get('/showAtv', AtividadeController.showActivity)
router.get('/showUser', UsuarioController.showUser)
router.get('/showUserAtv', usuarioAtividadeController.showUserActivity)


router.delete('/deleteAtv/:id', AtividadeController.deleteActivity)
router.delete('/deleteUser/:id', UsuarioController.deleteUser)
router.delete('/deleteUserAtv/:idUser/:idAtv', usuarioAtividadeController.deleteUserActivity)


router.put('/updateAtv/:id', AtividadeController.updateActivity)
router.put('/updateUser/:id', UsuarioController.updateUser)
router.put('/updateUserAtv/:idUser/:idAtv', usuarioAtividadeController.updateUserActivity)

module.exports = router