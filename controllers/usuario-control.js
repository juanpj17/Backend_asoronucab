import { pool } from '../models/server.js';
import { response, request } from 'express';

const buscarUsuario = async (req=request, res = response) => {
    const { correo,contrase } = req.params;
    
    console.log(req.params.correo)
    console.log(req.params.contrase)
    try {
      
      const usuario = await pool.query('SELECT( public.obtener_codigo_rif_cliente($1,$2)).*', [correo, contrase]);
      res.json(usuario.rows);
    } catch (error) {
      console.error('Error al buscar el usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};
export{buscarUsuario}