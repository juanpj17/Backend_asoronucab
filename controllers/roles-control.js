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
    console.log(req.body)
    try {
        const rol=await pool.query('SELECT public.insertar_rol($1,$2)',[req.body.nombre,req.body.descripcion])


        res.json(rol.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};


const modificarRol =  async(req, res = response) => {
    try {
        const rol=await pool.query('SELECT public.modificar_rol($1,$2,$3)',[req.body.id,req.body.nombre,req.body.descripcion])
        res.json(rol.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const obtenerRolId = async(req = request, res = response) => {
    try {
        const roles = await pool.query('SELECT (public.seleccionar_un_rol($1)).*',[req.body.id]);
        res.json(roles.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};
const eliminarRol = async(req = request, res = response) => {
    try {
        const roles = await pool.query('SELECT public.eliminar_rol($1)',[req.body.id]);
        res.json(roles.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }   
};
const buscarPermisos = async(req = request, res = response) => {
    try {
        const permisos = await pool.query('SELECT (public.obtener_permisos()).*');
        res.json(permisos.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }   
};
const asignarPermisos = async(req = request, res = response) => {
    console.log('asignar permisos')
    console.log(req.body)
    
    try {
        const permisos = await pool.query('SELECT public.insertar_permiso_rol($1,$2)',[req.body.codigo_permiso,req.body.codigo_rol]);
        res.json(permisos.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }   
};
const buscarPermisosRol = async(req = request, res = response) => {
    console.log(req.body)
    try {
        const permisos = await pool.query('SELECT public.seleccionar_codigos_permisos_rol($1)',[req.body.codigo_rol]);
        res.json(permisos.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }   
};
const eliminarPermisosRol = async(req = request, res = response) => {
    console.log(req.body)
    try {
        const permisos = await pool.query('SELECT public.eliminar_permisos_rol($1)',[req.body.codigo_rol]);
        res.json(permisos.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }   
};


export{
    rolesGet,
    rolesPost,
    modificarRol,
     eliminarRol,
    obtenerRolId,
    buscarPermisos,
    asignarPermisos,
    buscarPermisosRol,
    eliminarPermisosRol
    
}