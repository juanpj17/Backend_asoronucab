import { pool } from '../models/server.js';
import { response, request } from 'express';

const rolesGet = async(req = request, res = response) => {
    try {
        const roles = await pool.query('SELECT * FROM public.seleccionar_roles()');
        res.json(roles.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};



const rolesPost = async (req = request, res = response) => {
    try {
        


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const rolesPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const rolesDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    rolesGet,
    rolesPost,
    rolesPut,
    rolesDelete
}