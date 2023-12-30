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
      primerNombre,
      segundoNombre,
      primerApellido,
      segundoApellido,
      cedula,
      rif,
      sueldo,
      direccion,
      password,
      parroquia,
      rol,
      telefonos,
    } = req.body;
  
    try {
      // Agregar empleado
      const resultAgregarEmpleado = await pool.query(
        'CALL public.agregar_empleado($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)',
        [cedula, rif, primerNombre, segundoNombre, primerApellido, segundoApellido, direccion, sueldo, parroquia, password, rol]
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

const userDelete = (req, res = response) => {
    res.json({
        msg: 'Mensaje: metodo delete recibido - controlador'
    });
}

export{
    userGet,
    userPost,
    userPut,
    userDelete
}