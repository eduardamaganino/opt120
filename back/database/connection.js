const mysql = require('mysql');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'opt120' 
});

connection.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL');
  
  showActivities();
});

function showActivities() {
  const query = 'SELECT * FROM Usuario';
  
  connection.query(query, (error, results) => {
    if (error) {
      console.error('Erro ao executar consulta:', error);
      return;
    }
    
    console.log('Resultado da consulta:', results);
    connection.end((err) => {
      if (err) {
        console.error('Erro ao encerrar conexão:', err);
        return;
      }
      console.log('Conexão encerrada com sucesso');
    });
  });
}
