const database = require('../database/connection')
const connection = require('../database/connection')

class UsuarioAtividadeController {
    newUserActivity(req, res){
        const {usuario_id, atividade_id, entrega, nota} = req.body
        database.query('INSERT INTO opt120.usuario_atividade (usuario_id, atividade_id, entrega, nota) VALUES (?, ?, ?)', [usuario_id, atividade_id, entrega, nota], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    
    }

    showUserActivity(req, res){
        const query = 'SELECT * FROM opt120.usuario_atividade';
    
        database.query(query, (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Erro interno do servidor' });
                return;
            }
            
            console.log(results);
            res.json(results);
        });
    }

    deleteUserActivity(req, res){
        const { id } = req.params;
        database.query('DELETE FROM opt120.usuario_atividade WHERE id = ?', [id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }

    updateUserActivity(req, res) {
        const { usuario_id, atividade_id, entrega, nota } = req.body;
        const { id } = req.params;
        database.query('UPDATE opt120.usuario_atividade SET usuario_id = ?, atividade_id = ? WHERE id = ?', [usuario_id, atividade_id, id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }



}

module.exports = new UsuarioAtividadeController