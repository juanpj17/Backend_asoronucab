import { pool } from '../models/server.js';
import { response, request } from 'express';

const tiendaFisicaGet = async(req = request, res = response) => {
   
    
};

const tiendaFisicaPost = async(req, res = response) => {

    try {
        const { cod_pro, cod_eve} = req.body;
        const result = await pool.query(
            'SELECT verificar_presentacion($1, $2)',
            [cod_pro, cod_eve]
          );
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}

const tiendaFisicaPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const tiendaFisicaDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

const traerNamePost = async(req, res = response) => {

    try {
        const { cod_pro} = req.body;
        console.log(req.body)
        const result = await pool.query(
            'SELECT presentacion_particular($1)',
            [cod_pro]
          );
          console.log(result)
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}

const tiendaFisicaSolaPost = async(req, res = response) => {

    try {
        const { cod_pro, cod_eve} = req.body;
        const result = await pool.query(
            'SELECT verificar_presentacion($1, $2)',
            [cod_pro, cod_eve]
          );
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
    };
    
}


export{
    tiendaFisicaGet,
    tiendaFisicaPost,
    tiendaFisicaPut,
    tiendaFisicaDelete,
    traerNamePost,
    tiendaFisicaSolaPost
  
}