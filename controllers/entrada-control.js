import { pool } from '../models/server.js';
import { response, request } from 'express';

const entradaGet = async(req = request, res = response) => {

    
};

const entradaPost = async(req, res = response) => {
    try {
        const { codigo, fecha_inicial, fecha_final, precio } = req.body;
        console.log(req.body)
        const result = await pool.query(
            'SELECT * from insertar_entrada($1, $2, $3, $4)',
            [ codigo, fecha_inicial, fecha_final, precio]
          );
          


        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const entradaPut = async(req, res = response) => {
    try {
        const { codigo, precio } = req.body;
        const result = await pool.query(
            'SELECT actualizar_precio_entradas($1, $2)',
            [codigo, precio]
        );

        console.log('Entradas actualizadas correctamente.');
    } catch (error) {
        console.error('Error al ejecutar la actualización de entradas:', error);
    }
}

const entradaDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

const calculoPost = async(req, res = response) => {
    try {
        const { fecha_i, fecha_f } = req.body;
        console.log(req.body)
        const result = await pool.query(
            'SELECT * from public.calcular_dias_entre_fechas($1, $2)',
            [fecha_i, fecha_f]
          );
          


        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const entradasPost = async(req, res = response) => {
    try {
        const { cod} = req.body;
        // console.log(req.body)
        const result = await pool.query(
            'SELECT * from obtener_cantidad_entrada($1)',
            [cod]
          );
          


        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}



export{
    entradaGet,
    entradaPost,
    entradaPut,
    entradaDelete,
    calculoPost,
    entradasPost
}