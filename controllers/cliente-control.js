import { pool } from '../models/server.js';
import { response, request } from 'express';

const clienteGet = async(req = request, res = response) => {
    try {
        // const juridico = await pool.query('SELECT * FROM public.seleccionar_todos_cliente()');
        const natural = await pool.query('SELECT * FROM public.seleccionar_todos_clientes()');
        res.json(natural.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
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


const clienteGetN = async(req = request, res = response) => {
    try {
        const { cedula } = req.body;
        console.log(req.body)
        const cliente = await pool.query('SELECT * FROM public.seleccionar_un_cliente_natural_por_ci($1)', [cedula]);
        res.json(cliente.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePostN = async (req, res = response) => {
    
    try {
        const { p_nombre, s_nombre, p_apellido, s_apellido, cedula, rif, email, clave, parroquia, direccion} = req.body;
        // console.log('este es el query')
        // console.log(req.body)
        const result = await pool.query(
            'CALL public.agregar_cliente($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)',
            [p_nombre, s_nombre, p_apellido, s_apellido, cedula, rif, email, clave, parroquia, direccion]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
};
}


const buscarCorreoN = async(req, res = response) => {
       
    try {
        const { cedula } = req.body;
        // console.log('esta es la ci')
        // console.log(cedula)
        // console.log(req.body)
        const idEmpleado = await buscarIdClienteNPorCedula(cedula);
        const result = await pool.query(
            'SELECT * FROM public.consultar_correo_cliente($1, $2)',
            [cedula, idEmpleado]
        );

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

}


const modificarCorreo = async(req, res = response) => {
   
    try {
        const { cedula, correo } = req.body;
        // console.log('coreeooo')
        // console.log(req.body)
        const idEmpleado = await buscarIdClienteNPorCedula(cedula);
        const result = await pool.query(
            'SELECT * FROM public.modificar_clienteN_correo($1, $2, $3)',
            [correo, idEmpleado, cedula ]
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
        const idEmpleado = await buscarIdClienteNPorCedula(codigo);
        const result = await pool.query(
            'SELECT * FROM seleccionar_un_usuario_clienteN($1, $2)',
            [idEmpleado,codigo]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}





const clientePutN = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDeleteN = async (req, res = response) => {
    const { cedula } = req.query;
    console.log(req.query)
    console.log(cedula)
    try {
      const idCliente = await buscarIdClienteNPorCedula(cedula)
      const mensaje = await pool.query('SELECT public.eliminar_un_cliente_natural($1, $2)', [ idCliente, cedula]);
      res.json({ mensaje: `ClienteN con cédula ${cedula} ${mensaje}` });
    } catch (error) {
      console.error('Error al eliminar el clienteN:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
}

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
  



const clienteGetJ = async(req = request, res = response) => {
    try {
   
        const { rif } = req.query;

        
        const cliente = await pool.query('SELECT * FROM public.seleccionar_un_cliente_juridico($1)',[rif]);
        res.json(cliente.rows);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
    
};

const clientePostJ = async (req, res = response) => {

    try {

        const { denominacion_comercial, razon_social, pagina_web, capital_disponible, 
                rif, clave, parroquia_fisica, direccion_fisica ,parroquia_fiscal, direccion_fiscal, 
                tipo_fisica, tipo_fiscal} = req.body;
            console.log('aqui post ')
            
            console.log(req.body)
        const result = await pool.query(
            'CALL agregar_juridico($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)',
            [denominacion_comercial, razon_social, pagina_web, capital_disponible, 
             rif, clave, parroquia_fisica, direccion_fisica ,parroquia_fiscal, direccion_fiscal, 
             tipo_fisica, tipo_fiscal]
          );
          


        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    
};
}

const clientePutJ = (req, res = response) => {

    const id = req.params.id;

    res.json({
        msg: 'Mensaje: metodo put recibido - controlador',
        id
    });
}

const clienteDeleteJ = async (req, res = response) => {
    const { doc } = req.query;

    try {

      const mensaje = await pool.query('SELECT public.eliminar_un_cliente_juridico($1)', [doc]);
      res.json({ mensaje: `Cliente con doc ${doc} ${mensaje}` });
    } catch (error) {
      console.error('Error al eliminar el cliente:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const telefonoClienteN = async(req, res = response) => {
 
    try {
        const { numero, codigo1 } = req.body;
        console.log(codigo1)
        const idCliente = await buscarIdClienteNPorCedula(codigo1)
        const result = await pool.query(
            'SELECT * FROM "insertar_telefono_clienteN"($1, $2, $3)',
            [numero, idCliente, codigo1]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

const modificarClienteN = async(req, res = response) => {

    try {
        const { ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia } = req.body;
        console.log(ced)
        const idCliente = await buscarIdClienteNPorCedula(ced)
        const result = await pool.query(
            'SELECT * FROM public.modificar_cliente_natural($1, $2, $3, $4, $5, $6, $7, $8, $9)',
            [idCliente, ced, rif, p_nombre, s_nombre, p_apellido, s_apellido, direccion, parroquia]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}


const modificarUsuario = async(req, res = response) => {
    try {
        const { clave, cliente2, empleado1, empleado2, juridico, rol } = req.body;
        // console.log('reque')
        // console.log(req.body)
        const idCliente = await buscarIdClienteNPorCedula(cliente2);
        const result = await pool.query(
            'SELECT * FROM public.modificar_usuario_password($1, $2, $3, $4, $5, $6, $7)',
            [clave, idCliente, cliente2, empleado1, empleado2, juridico, rol ]
        );

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }

}



const consultarClienteJ = async(req, res = response) => {

    try {
        const { rif } = req.body;
        console.log(rif)
        const result = await pool.query(
            'SELECT * FROM public.seleccionar_un_cliente_juridico($1)',
            [rif]
          );
          
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}




export{
    clienteGet,
    clientePost,
    clientePut,
    clienteDelete,
    clienteGetN,
    clientePostN,
    clientePutN,
    clienteDeleteN,
    clienteGetJ,
    clientePostJ,
    clientePutJ,
    clienteDeleteJ,
    buscarIdClienteNPorCedula,
    telefonoClienteN,
    modificarClienteN,
    modificarUsuario,
    consultarClienteJ,
    buscarCorreoN,
    consultarUsuario,
    modificarCorreo
}