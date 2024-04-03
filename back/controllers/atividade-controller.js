const database = require('../database/connection')

class AtividadeController {
    newActivity(req, res){
        const {titulo, descricao, nota, data_atv} = req.body
        database.query('INSERT INTO opt120.Atividade (titulo, descricao, nota, data_atv) VALUES (?, ?, ?, ?)', [titulo, descricao, nota, data_atv], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }

    showActivity(req, res){
        const query = 'SELECT * FROM opt120.Atividade';
        const teste = []
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

    deleteActivity(req, res){
        const { id } = req.params;
        database.query('DELETE FROM opt120.Atividade WHERE id = ?', [id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }

    updateActivity(req, res){
        const {titulo, descricao, nota, data_atv} = req.body;
        const {id} = req.params;
        database.query('UPDATE opt120.Atividade SET titulo = ?, descricao = ? WHERE id = ?', [titulo, descricao, id], (err, results) => {
            if (err) throw err;
            res.json(results);
          });
    }


}

module.exports = new AtividadeController