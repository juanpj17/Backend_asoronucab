import { pool } from '../models/server.js';
import { response, request } from 'express';

const graficar = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const productos = await pool.query('SELECT * from obtenerVentasPorMes($1 , $2)', [mes_i, mes_f]);

       res.json(productos.rows);
    } catch (error) {
      console.error('Error al buscar los productos:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const graficarVentas = async (req=request, res = response) => {

    try {
      const productos = await pool.query('SELECT * from obtenerVentasPorCliente()');
       res.json(productos.rows);
    } catch (error) {
      console.error('Error al buscar las ventas:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const graficarTres = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const productos = await pool.query('SELECT * from obtenerVentasPorProducto($1 , $2)', [mes_i, mes_f]);

       res.json(productos.rows);
    } catch (error) {
      console.error('Error al buscar los productos:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const tablaColumna1 = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const productos = await pool.query('SELECT * from obtenerCantidadVentas($1 , $2)', [mes_i, mes_f]);

       res.json(productos.rows);
    } catch (error) {
      console.error('Error al buscar los productos:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const tablaColumna2 = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const puntos = await pool.query('SELECT * from obtenerTotalPuntos($1 , $2)', [mes_i, mes_f]);

       res.json(puntos.rows);
    } catch (error) {
      console.error('Error al buscar los puntos:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const graficarOrdenes = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const ordenes = await pool.query('SELECT * from obtenerCantidadesPorEstatus($1 , $2)', [mes_i, mes_f]);

       res.json(ordenes.rows);
    } catch (error) {
      console.error('Error al buscar los ordenes:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const columnaCuatro = async (req=request, res = response) => {
    const { mes_i, mes_f } = req.body;
    
    console.log(req.body)  
    try {

      const ordenes = await pool.query('SELECT * from contarOrdenesConFechaFinalNull($1 , $2)', [mes_i, mes_f]);

       res.json(ordenes.rows);
    } catch (error) {
      console.error('Error al buscar los ordenes:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};
export{graficar, graficarVentas, graficarTres, tablaColumna1, tablaColumna2, graficarOrdenes, columnaCuatro}