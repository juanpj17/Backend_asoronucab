import { pool } from '../models/server.js';
import { response, request } from 'express';

const clienteGet = async(req = request, res = response) => {
    try {
        // const juridico = await pool.query('SELECT * FROM public.seleccionar_todos_cliente()');
        const natural = await pool.query('SELECT * FROM public.seleccionar_todos_cliente()');
        res.json(natural.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const clientePut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}


const clienteGetN = async(req = request, res = response) => {
    try {
        const { cedula } = req.query;
        console.log(req.query)
        const cliente = await pool.query('SELECT * FROM public.seleccionar_un_cliente_natural_por_ci($1)', [cedula]);
        res.json(cliente.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePostN = async (req, res = response) => {
    try {
        const { ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia} = req.body;
        
        const result = await pool.query(
            'SELECT public.registro_cliente_natural($1, $2, $3, $4, $5, $6, $7, $8)',
            [ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
};
}

const clientePutN = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDeleteN = async (req, res = response) => {
    const { cedula } = req.query;
    console.log(req.query)
    try {

      const mensaje = await pool.query('SELECT public.eliminar_un_cliente_natural_por_ci($2)', [ cedula]);
      res.json({ mensaje: `Empleado con cédula ${cedula} ${mensaje}` });
    } catch (error) {
      console.error('Error al eliminar el empleado:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
}



const clienteGetJ = async(req = request, res = response) => {
    try {
   
        const { rif } = req.query;
        console.log(rif)
        
        const cliente = await pool.query('SELECT * FROM public.seleccionar_un_cliente_juridico($1)',[rif]);
        res.json(cliente.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePostJ = async (req, res = response) => {
    try {

        const { rif, denominacion_comer, razon_soc, pagina_web, direccion_fisica, direccion_fiscal, capital} = req.body;
        console.log(req.body)
        const result = await pool.query(
            'SELECT public.insertar_cliente_juridico($1, $2, $3, $4, $5, $6, $7)',
            [rif, denominacion_comer, razon_soc, pagina_web, direccion_fisica, direccion_fiscal, capital]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
};
}

const clientePutJ = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDeleteJ = async (req, res = response) => {
    const { codigo, cedula } = req.query;

    try {

      const mensaje = await pool.query('SELECT public.eliminar_un_cliente_natural($1, $2)', [codigo, cedula]);
      res.json({ mensaje: `Empleado con cédula ${cedula} ${mensaje}` });
    } catch (error) {
      console.error('Error al eliminar el empleado:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
}




export{
    clienteGet,
    clientePost,
    clientePut,
    clienteDelete,
    clienteGetN,
    clientePostN,
    clientePutN,
    clienteDeleteN,
    clienteGetJ,
    clientePostJ,
    clientePutJ,
    clienteDeleteJ,
}