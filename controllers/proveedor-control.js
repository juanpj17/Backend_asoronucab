
import { pool } from '../models/server.js';
import { response, request } from 'express';

const proveedorGet = async(req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM obtener_proveedores()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};



const  proveedorPost = async (req = request, res = response) => {
    try {
        const evento = await pool.query('SELECT * FROM obtener_proveedores()');
        res.json(evento.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const  proveedorPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const presentacionesxProveedor = async (req=request, res = response) => {
 
    try {
        console.log('akldndnmk')
      console.log(req.body.params.proveedor)
      const usuario = await pool.query('SELECT * from obtener_presentaciones_por_proveedor($1)', [req.body.params.proveedor]);
      res.json(usuario.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };

const proveedorDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
     proveedorGet,
     proveedorPost,
     proveedorPut,
     proveedorDelete,
     presentacionesxProveedor
}