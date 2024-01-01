import { pool } from '../models/server.js';
import { response, request } from 'express';

const empleadoGet = async (req = request, res = response) => {
    try {
        const empleado = await pool.query('SELECT * FROM public.mostrar_empleados()');
        res.json(empleado.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const empleadoDelete = async (req, res = response) => {
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

const consultarEmpleado = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;
        const idEmpleado = await buscarIdEmpleadoPorCedula(codigo);
        const result = await pool.query(
            'SELECT * FROM public.seleccionar_empleado($1, $2)',
            [idEmpleado,codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const consultarTelefonoEmpleado = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;
        console.log(codigo)
        const idEmpleado = await buscarIdEmpleadoPorCedula(codigo);
        const result = await pool.query(
            'SELECT * FROM seleccionar_telefonos_empleado($1, $2)',
            [idEmpleado, codigo]
          );
          
        res.json(result.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}




const telefonoEmpleado = async(req, res = response) => {
 
    try {
        const { numero, codigo1 } = req.body;
        const idEmpleado = await buscarIdEmpleadoPorCedula(codigo1);
        const result = await pool.query(
            'SELECT * FROM insertar_telefono_empleado($1, $2, $3)',
            [numero, codigo1, idEmpleado]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}




const consultarUsuario = async(req, res = response) => {
 
    try {
        const { codigo } = req.body;
        const idEmpleado = await buscarIdEmpleadoPorCedula(codigo);
        const result = await pool.query(
            'SELECT * FROM seleccionar_un_usuario($1, $2)',
            [idEmpleado,codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const modificarUsuario = async(req, res = response) => {
   
        try {
            const { clave, cliente1, cliente2, codigo, juridico, rol } = req.body;
            const idEmpleado = await buscarIdEmpleadoPorCedula(codigo);
            const result = await pool.query(
                'SELECT * FROM public.modificar_usuario_password($1, $2, $3, $4, $5, $6, $7)',
                [clave, cliente1, cliente2, idEmpleado, codigo, juridico, rol ]
            );
    
            res.json(result.rows[0]);
        } catch (error) {
            console.error('Error al ejecutar la consulta:', error);
            res.status(500).json({ error: 'Error interno del servidor' });
        }

}




const modificarEmpleado = async(req, res = response) => {
       
    try {
        const { cedula, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, sueldo, parroquia } = req.body;
        console.log(cedula)
        console.log(p_nombre)
        console.log(req.body)
        const idEmpleado = await buscarIdEmpleadoPorCedula(cedula);
        const result = await pool.query(
            'SELECT * FROM public.modificar_empleado($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
            [idEmpleado, cedula, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, sueldo, parroquia]
        );

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

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
  


const empleadoPost = async (req = request, res = response) => {

    const 
    {
        cedula, rif,
        p_nombre, s_nombre,
        p_apellido, s_apellido,
        direccion, sueldo,
        parroquia, contraseña,
        rol, correo,
        telefonos
    } = req.body;

    try{
        const dbresponse = await pool.query(
            'CALL public.agregar_empleado($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)',
            [
                cedula, rif, 
                p_nombre, s_nombre, 
                p_apellido, s_apellido, 
                direccion, sueldo, 
                parroquia, contraseña,
                rol, correo
            ]
        )
        
        const id = await buscarIdEmpleadoPorCedula(cedula);
   
        
        
        await Promise.all(
            telefonos.map(async (telefono) => {
                const dbresponseTelefono = await pool.query('SELECT public.insertar_telefono_empleado($1, $2, $3)', [telefono, id, cedula]);
                console.log(dbresponseTelefono.rows[0].mensaje);
            })
        );
  
        res.json({
            msg: 'Mensaje: método post recibido - controlador',
            dbresponse,
        });

    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

};

const empleadoPut = () => {



}

export{
    empleadoGet,
    empleadoPost,
    empleadoPut,
    empleadoDelete,
    consultarEmpleado,
    consultarUsuario,
    modificarUsuario,
    modificarEmpleado,
    telefonoEmpleado,
    consultarTelefonoEmpleado
}