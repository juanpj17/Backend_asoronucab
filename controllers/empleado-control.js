import { pool } from '../models/server.js';
import { response, request } from 'express';

const userGet = async (req = request, res = response) => {
    try {
        const empleado = await pool.query('SELECT * FROM public.mostrar_empleados()');
        res.json(empleado.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const userPost = async (req = request, res = response) => {
    try {
        const { ci, rif, nombre_p, nombre_s, p_apellido, s_apellido, direccion, sueldo , fecha_ingreso , fk_cliente_juridico, fk_proveedor, fk_lugar} = req.body;

        const result = await pool.query(
            'Select public.agregar_empleado($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)',
            [ci, rif, nombre_p, nombre_s, p_apellido, s_apellido, direccion, sueldo , fecha_ingreso , fk_cliente_juridico, fk_proveedor, fk_lugar]
        );

        
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};




const userPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const userDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    userGet,
    userPost,
    userPut,
    userDelete
}