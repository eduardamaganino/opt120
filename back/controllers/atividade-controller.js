const database = require('../database/connection')
const connection = require('../database/connection')

class AtividadeController {
    newActivity(request, response){
        const {titulo, descricao, nota, data_atv} = request.body

        console.log(titulo, descricao, nota, data_atv)

        database.insert({titulo, descricao, nota, data_atv}),table("Atividade").then(data=>{
            console.log(data)
            response.json({message:"Tarefa criada com sucesso !"}) 
        }).catch(error=>{
            console.log(error)
        })
    }

    showActivity(request, response){
        const query = 'SELECT * FROM opt120.Usuario';
    
        connection.query(query, (error, results) => {
            if (error) {
                console.error(error);
                response.status(500).json({ error: 'Erro interno do servidor' });
                return;
            }
            
            console.log(results);
            response.json(results);
        });
    }

    deleteActivity(request, response){
        
    }

    updateActivity(request, response){
        
    }


}

module.exports = new AtividadeController