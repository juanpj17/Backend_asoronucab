
import { pool } from '../models/server.js';
import { response, request } from 'express';

const DatosFactura = async (req=request, res = response) => {
    try {
      console.log(req.body)
      const factura =await pool.query('SELECT (public.datos_factura($1)).*',[req.body.codigo_identificador]);
     
      res.json(factura.rows[0]);
     
    
     
    } catch (error) {
      console.error('Error al obtener datos de la factura afiliacion:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
    
  };
  const DatosAfiliado = async (req=request, res = response) => {
    try {
      console.log(req.body)
      const factura =await pool.query('SELECT (public.obtener_datos_afiliado_factura($1)).*',[req.body.codigo_identificador]);
     
      res.json(factura.rows[0]);
     
    
     
    } catch (error) {
      console.error('Error al obtener datos de la factura afiliacion:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };
  const DatosAsoron = async (req=request, res = response) => {
    try {
      console.log(req.body)
      const factura =await pool.query('SELECT (public.obtener_datos_asoron_factura()).*');
     
      res.json(factura.rows[0]);
     
    
     
    } catch (error) {
      console.error('Error al obtener datos de la factura afiliacion:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };

  export{DatosFactura,DatosAfiliado,DatosAsoron}