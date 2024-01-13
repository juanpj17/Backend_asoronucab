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
      console.log('aca,', req.body)
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

const eventoPut = async (req = request, res = response) => {
    try {
        const { codigo, nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia } = req.body;

        const result = await pool.query(
            'SELECT modificar_evento($1, $2, $3, $4, $5, $6, $7, $8)',
            [codigo, nombre, descripcion, num_entradas, fecha_hora_inicial, fecha_hora_final, direccion, parroquia]
        );

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const eventoDelete = async(req, res = response) => {

    const { codigo } = req.query;

    try {
        const result = await pool.query('SELECT eliminar_evento($1)', [codigo]);
        console.log('Evento eliminado con éxito');

        // Puedes hacer algo más con el resultado si es necesario
      } catch (error) {
        console.error('Error al eliminar el evento:', error);
        // Maneja el error según sea necesario
      }
}



const eventoHora = async(req, res = response) => {

    try {
        const result = await pool.query('SELECT * FROM public.obtener_eventos_activos()');

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
        const evento = await pool.query('SELECT * FROM public.ultimo_id()');
        res.json(evento.rows);
  

    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};


const consultarEvento = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;

        const result = await pool.query(
            'SELECT * FROM seleccionar_un_evento($1)',
            [codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const lugarEvento = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;

        const result = await pool.query(
            'SELECT * FROM seleccionar_un_lugar($1)',
            [codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}




const fk_presentacionEvento = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;


        const result = await pool.query(
            'SELECT * FROM seleccionar_una_presentacion1($1)',
            [codigo]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}




const nombreEvento = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;

        const result = await pool.query(
            'SELECT * FROM seleccionar_una_presentacion2($1)',
            [codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const insertarNotaCata = async (req=request, res = response) => {
 
    try {
      console.log(req.body)
      const usuario = await pool.query('SELECT public.insertar_nota_cata($1,$2,$3)', [req.body.nota,req.body.evento,req.body.presentacion]);
      res.json(usuario.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };
  const obtenerPremios = async (req=request, res = response) => {
 
    try {
      const premios = await pool.query('SELECT (public.obtener_premios()).*');
      res.json(premios.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };
  const obtenerPresentaciones = async (req=request, res = response) => {
    console.log(req.body)
    try {
      const presentacion = await pool.query('SELECT (public.obtener_presentaciones_producto($1)).*',[req.body.cod_producto]);
      res.json(presentacion.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };

  const presentacionesxProveedor = async (req=request, res = response) => {
 
    try {
      console.log(req.body)
      const usuario = await pool.query('SELECT * from obtener_presentaciones_por_proveedor($1)', [req.body.proveedor]);
      res.json(usuario.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };


  const insertarPremio = async (req=request, res = response) => {
 
    try {
      console.log(req.body)
      const usuario = await pool.query('SELECT public.insertar_premio_evento($1,$2,$3)', [req.body.evento,req.body.presentacion,req.body.premio]);
      res.json(usuario.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
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
    ultimoEventoGet,
    consultarEvento,
    lugarEvento,
    fk_presentacionEvento,
    nombreEvento,
    insertarNotaCata,
    obtenerPremios,
    obtenerPresentaciones,
    insertarPremio,
    presentacionesxProveedor
}