import { pool } from '../models/server.js';
import { response, request } from 'express';

const productoGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_productos()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoParroquiasGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM parroquias()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoProveedorGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_proveedor()');
        res.json(productos.rows);   

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
    
    const {
        nombre,
        descripcion,
        gradosa,
        tipo,
        anejamiento,
        proveedor,
        parroquia,
        categoria,
        variedad
    } = req.body
    console.log(req.body)
    try {
        
        const dbresponse = await pool.query('SELECT public.registrar_producto($1, $2, $3, $4, $5, $6, $7, $8, $9)', 
        [
            nombre, 
            descripcion, 
            gradosa, 
            tipo, 
            anejamiento, 
            proveedor, 
            parroquia, 
            categoria, 
            variedad
        ]);

        res.json(dbresponse.rows[0]);

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

const productoDelete = async(req, res = response) => {
   
    const codigo = req.params.codigo;

    try{

        const dbresponse = await pool.query('SELECT eliminar_producto($1)', [codigo]);
        res.json(' solicitud recibida ');

    }catch(error) {

        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });

    }
    

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
    productoParroquiasGet,
    productoProveedorGet
}