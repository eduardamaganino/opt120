const database = require('../database/connection')

class UsuarioController {
    newUser(req, res){
        const {nome, email, senha} = req.body
        database.query('INSERT INTO opt120.Usuario (nome, email, senha) VALUES (?, ?, ?)', [nome, email, senha], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    
    }

    showUser(req, res){
        const query = 'SELECT * FROM opt120.Usuario';
    
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

    deleteUser(req, res){
        const { id } = req.params;
        database.query('DELETE FROM opt120.Usuario WHERE id = ?', [id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }

    updateUser(req, res) {
        const { nome, email, senha } = req.body;
        const { id } = req.params;
        database.query('UPDATE opt120.Usuario SET nome = ?, email = ? WHERE id = ?', [nome, email, id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }


}

module.exports = new UsuarioController