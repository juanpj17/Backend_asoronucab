import { pool } from '../models/server.js';
import { response, request } from 'express';

const eventoGet = async(req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM seleccionar_eventos()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

// const eventoPost = (req, res = response) => {

//     const { nombre, edad } = req.body;

//     res.json({
//         msg: 'Mensaje: metodo post recibido - controlador',
//         nombre,
//         edad
//     });
// }

const eventoPost = async (req = request, res = response) => {
    try {
        const { nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia } = req.body;

        const result = await pool.query(
            'SELECT insertar_evento($1, $2, $3, $4, $5, $6, $7)',
            [nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const eventoPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const eventoDelete = async(req, res = response) => {
    console.log('llega?')
    const { codigo } = req.query;
    console.log(req.query)
    try {
        const result = await pool.query('SELECT eliminar_evento($1)', [codigo]);
        console.log('Evento eliminado con éxito');
        console.log(result)
        // Puedes hacer algo más con el resultado si es necesario
      } catch (error) {
        console.error('Error al eliminar el evento:', error);
        // Maneja el error según sea necesario
      }
}



const eventoHora = async(req, res = response) => {

    try {
        const result = await pool.query('SELECT * FROM public.obtener_eventos_activos()');
        console.log('Eventos consultados con éxito');
        res.json(result.rows);
      } catch (error) {
        console.error('Error al buscar los eventos:', error);
        // Maneja el error según sea necesario
      }
}

const presentacionEvento = async(req, res = response) => {
 
    try {
        const { cantidad, precio, cod_presentacion, cod_evento, cod_premio } = req.body;
        console.log(req.body)
        const result = await pool.query(
            'CALL insertar_presentacion_evento($1, $2, $3, $4, $5)',
            [cantidad, precio, cod_presentacion, cod_evento, cod_premio]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const ultimoEventoGet = async(req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM ultimo_id()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};



export{
    eventoGet,
    eventoPost,
    eventoPut,
    eventoDelete,
    eventoHora,
    presentacionEvento,
    ultimoEventoGet
}