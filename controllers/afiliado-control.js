import { pool } from '../models/server.js';
import { response, request } from 'express';

const buscarDatosCarnet = async (req=request, res = response) => {
    const { codigo_tipo_registro } = req.params;
    
    console.log(codigo_tipo_registro)
   
    try {
      
      const datos_carnet = await pool.query('SELECT (public.datos_carnet($1)).*', [codigo_tipo_registro]);
      console.log(datos_carnet.rows[0].cedula)

      
       res.json(datos_carnet.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const generarCodigo = async () => {
    try {
      const codigo = await pool.query('SELECT public.generar_secuencia()');
      return codigo.rows[0];
    } catch (error) {
      console.error('Error al obter el codigo de carnet ', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const pagarCuotaAfiliacion = async (req=request, res = response) => {
  try {
    const codigo=req.body.montos;
    console.log(req.body)
    const pago =await pool.query('SELECT public.pagar($1, $2, $3, $4,$5)',[req.body.codigo_identificador, req.body.montos, req.params.tarjetas, req.body.cuota,req.body.cant_elementos]);
    res.json(pago.rows[0]);
  } catch (error) {
    console.error('Error al buscar el pagar afiliacion:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
  
};

export{buscarDatosCarnet,pagarCuotaAfiliacion}