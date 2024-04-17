const database = require('../database/connection');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

class UsuarioController {
    newUser(req, res) {
        const { nome, email, senha } = req.body;
        const hashedSenha = bcrypt.hashSync(senha, 10); // Hash da senha

        database.query('INSERT INTO opt120.Usuario (nome, email, senha) VALUES (?, ?, ?)', [nome, email, hashedSenha], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }

    login(req, res) {
        const { email, senha } = req.body;

        database.query('SELECT * FROM opt120.Usuario WHERE email = ?', [email], (error, results) => {
            const usuario = results[0];
            const senhaCorreta = bcrypt.compareSync(senha, usuario.senha); // Verifica se a senha está correta
            
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Erro interno do servidor' });
                return;
            }

            if (results.length === 0) {
                res.status(401).json({ error: 'Credenciais inválidas' });
                return;
            }

          
            if (!senhaCorreta) {
                res.status(401).json({ error: 'Senha inválidas' });
                return;
            }

            const token = jwt.sign({ id: usuario.id }, 'chave-secreta'); // Gera o token JWT

            res.json({ id: usuario.id, token });
        });
    }

    showUserById(req, res) {
        const { id } = req.params;
        const query = 'SELECT * FROM opt120.Usuario WHERE id = ?';

        database.query(query, [id], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Erro interno do servidor' });
                return;
            }

            if (results.length === 0) {
                res.status(404).json({ error: 'Usuário não encontrado' });
                return;
            }

            const usuario = results[0];
            res.json(usuario);
        });
    }

    showUser(req, res) {
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

    deleteUser(req, res) {
        const { id } = req.params;
        database.query('SELECT * FROM opt120.Usuario WHERE id = ?', [id], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Erro interno do servidor' });
                return;
            }

            if (results.length === 0) {
                res.status(404).json({ error: 'Usuário não encontrado' });
                return;
            }

            const usuario = results[0];
            res.json(usuario);
        });
    }

    updateUser(req, res) {
        const { nome, email } = req.body;
        const { id } = req.params;
        database.query('UPDATE opt120.Usuario SET nome = ?, email = ? WHERE id = ?', [nome, email, id], (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    }
}

module.exports = new UsuarioController;