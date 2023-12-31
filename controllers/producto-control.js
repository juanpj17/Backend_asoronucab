import { pool } from '../models/server.js';
import { response, request } from 'express';

const productoGet = async(req = request, res = response) => {
    try {
        const producto = await pool.query('SELECT * FROM public.seleccionar_roles()');
        res.json(producto.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const productoByProveedor = async(req = request, res = response) => {
    try {
        const { proveedor } = req.query;
        console.log('estoy recibiendo esto this.proveedor')
        console.log(proveedor)
        const productos = await pool.query('SELECT * FROM obtener_productos_por_proveedor($1)', [proveedor]);
        res.json(productos.rows);
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });
      }
    
};



const productoPost = async (req = request, res = response) => {
    try {
        


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const productoPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const productoDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}


const presentacionByProveedor = async(req = request, res = response) => {
    try {
       
        const { proveedor } = req.query;
       
     
        const productos = await pool.query('SELECT * FROM obtener_presentaciones_por_proveedor($1)', [proveedor]);
        res.json(productos.rows);
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });
      }
    
};




export{
    productoGet,
    productoPost,
    productoPut,
    productoDelete,
    productoByProveedor,
    presentacionByProveedor,
}