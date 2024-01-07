import { pool } from '../models/server.js';
import { response, request } from 'express';

const ordenesActivas = async (req = request, res = response) => {
    try {
        const ordenes = await pool.query('SELECT (public.codigo_ordenes_reposicion()).*');
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const datosOrdenCompra = async (req = request, res = response) => {
    try {
        const ordenes = await pool.query('SELECT (public.factura_ordenes_reposicion($1)).*',[req.body.id]);
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const direccionProveedor = async (req = request, res = response) => {
    console.log(req.body)
    try {
        const ordenes = await pool.query('SELECT public.direccion_proveedor($1)',[req.body.id]);
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const fechaOrden = async (req = request, res = response) => {
    console.log(req.body)
    try {
        const ordenes = await pool.query('SELECT public.fecha_orden($1)',[req.body.id]);
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const ordenes = async (req = request, res = response) => {
    try {
        const ordenes = await pool.query('SELECT (public.ordenes_compra()).*');
        console.log(ordenes)
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
const actualizar = async (req = request, res = response) => {
    console.log(req.body)
    try {
        const ordenes = await pool.query('SELECT public.actualizar_ordenes_compra($1)',[req.body.id]);
        res.json(ordenes.rows);
        
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};
export{
ordenesActivas,datosOrdenCompra,direccionProveedor,fechaOrden,ordenes,actualizar
}