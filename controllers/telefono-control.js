import { pool } from '../models/server.js';
import { response, request } from 'express';

const buscarIdEmpleadoPorCedula = async (cedula) => {
    try {
      const result = await pool.query('SELECT per_nat_id FROM public."Empleado" WHERE per_nat_ci = $1', [cedula]);
      if (result.rows.length > 0) {
        return result.rows[0].per_nat_id;
      } else {
        throw new Error('Empleado no encontrado');
      }
    } catch (error) {
      console.error('Error al buscar el ID del empleado:', error);
      throw new Error('Error interno del servidor');
    }
  };

  const buscarIdClienteNPorCedula = async (cedula) => {
    try {
      const result = await pool.query('SELECT per_nat_id FROM public."Cliente_Natural" WHERE per_nat_ci = $1', [cedula]);
      if (result.rows.length > 0) {
        return result.rows[0].per_nat_id;
      } else {
        throw new Error('ClienteN no encontrado');
      }
    } catch (error) {
      console.error('Error al buscar el ID del clienteN:', error);
      throw new Error('Error interno del servidor');
    }
  };

const telefonoGet = async(req = request, res = response) => {
   
    
};

const telefonoPost = (req, res = response) => {

    const { nombre, edad } = req.body;

    res.json({
        msg: 'Mensaje: metodo post recibido - controlador',
        nombre,
        edad
    });
}

const telefonoPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const telefonoDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

const eliminarNumerosEmpleado = async(req, res = response) => {
 
    try {
        const { cedula } = req.body;
        const idEmpleado = await buscarIdEmpleadoPorCedula(cedula);
        const result = await pool.query(
            'SELECT * FROM eliminar_telefonos_por_codigo($1, $2)',
            [idEmpleado, cedula]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const obtenerNumerosCliente = async(req, res = response) => {
 
  try {
      const { cedula } = req.body;
      console.log('necesito: ')
      console.log(req.body)
      const idCliente = await buscarIdClienteNPorCedula(cedula);
      const result = await pool.query(
          'SELECT * from obtener_telefonos_cliente_n($1, $2)',
          [idCliente, cedula]
        );
        
      res.json(result.rows);
  } catch (error) {
      console.error('Error al ejecutar la consulta:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
  }
}



const eliminarNumerosCliente = async(req, res = response) => {
 
  try {
      const { cedula } = req.body;
      const idCliente = await buscarIdClienteNPorCedula(cedula);
      const result = await pool.query(
          'SELECT * FROM eliminar_telefonos_cliente($1, $2)',
          [idCliente, cedula]
        );
        
      res.json(result.rows);
  } catch (error) {
      console.error('Error al ejecutar la consulta:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
  }
}



export{
    telefonoGet,
    telefonoPost,
    telefonoPut,
    telefonoDelete,
    eliminarNumerosEmpleado,
    eliminarNumerosCliente,
    obtenerNumerosCliente
}