import { pool } from '../models/server.js';
import { response, request } from 'express';

const clienteGet = (req = request, res = response) => {
    res.send("Hola mundo");
};

const clientePost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const clientePut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    clienteGet,
    clientePost,
    clientePut,
    clienteDelete
}