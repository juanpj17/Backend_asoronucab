import { pool } from '../models/server.js';
import { response, request } from 'express';

const userGet = async (req = request, res = response) => {
    try {
        const empleado = await pool.query('SELECT * FROM public.mostrar_empleados()');
        res.json(empleado.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const userPost = async (req, res = response) => {
    const {
      cedula,
      rif,
      primerNombre,
      segundoNombre,
      primerApellido,
      segundoApellido,
      direccion,
      sueldo,
      fecha_ing,
      parroquia,
      password,
      rol,
      telefonos,
    } = req.body;
  
    try {
  
      const resultAgregarEmpleado = await pool.query(
        'CALL public.agregar_empleado($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)',
        [cedula, rif, primerNombre, segundoNombre, primerApellido, segundoApellido, direccion, sueldo, fecha_ing ,parroquia, password, rol]
      );
    
     // Obtener el ID del empleado recién insertado
        const { per_nat_id, per_nat_ci } = resultAgregarEmpleado.rows[0];
        const cod1_empleado = per_nat_id;
        const cod2_empleado = per_nat_ci; 
        // Insertar teléfono
        telefonos.forEach(async (numero) => {
            const resultTelefono = await pool.query(
                'SELECT public.insertar_telefono($1, $2, $3) as mensaje',
                [numero, cod1_empleado, cod2_empleado]
            );
            
            console.log(resultTelefono.rows[0].mensaje); 
        });
    } catch (error) {
      console.error('Error al ejecutar las consultas:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  };


const userPut = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

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
  
const userDelete = async (req, res = response) => {
    const { cedula } = req.params;
  
    try {
      const idEmpleado = await buscarIdEmpleadoPorCedula(cedula);
      const mensaje = await pool.query('SELECT public.eliminar_empleado($1, $2)', [idEmpleado, cedula]);
      res.json({ mensaje: `Empleado con cédula ${cedula} ${mensaje}` });
    } catch (error) {
      console.error('Error al eliminar el empleado:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
};

export{
    userGet,
    userPost,
    userPut,
    userDelete
}