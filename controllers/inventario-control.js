import { pool } from '../models/server.js';
import { response, request } from 'express';

const generarReporteVenta = async (req = request, res = response) => {

    try{

        const { dato } = req.params;
        const reporte = await pool.query('SELECT (public.detalles_inventario_virtual_venta($1)).*', [dato]);

        res.json(reporte.rows);

    } catch (error) {
        console.error('Error al buscar el usuario:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

};

const generarReporteCompra = async (req = request, res = response) => {

    try{

        const { dato } = req.params;

        const reporte = await pool.query('SELECT (public.detalles_inventario_virtual_compra($1)).*', [dato]);

        res.json(reporte.rows);

    } catch (error) {
        console.error('Error al buscar el usuario:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

};

const generarReporteVentaFisica = async (req = request, res = response) => {

    try{

        const { dato } = req.params;
        const reporte = await pool.query('SELECT (public.detalles_inventario_fisico($1)).*', [dato]);

        res.json(reporte.rows);

    } catch (error) {
        console.error('Error al buscar el usuario:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

};

const generarReporteVentaFisicaEvento = async (req = request, res = response) => {

    try{

        const { dato } = req.params;
        const reporte = await pool.query('SELECT (public.detalles_inventario_fisico_evento($1)).*', [dato]);

        res.json(reporte.rows);

    } catch (error) {
        console.error('Error al buscar el usuario:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

};

export 
{ 
    generarReporteVenta, 
    generarReporteCompra, 
    generarReporteVentaFisica,
    generarReporteVentaFisicaEvento
}