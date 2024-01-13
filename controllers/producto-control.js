import { pool } from '../models/server.js';
import { response, request } from 'express';

const productoGet = async(req = request, res = response) => {
    console.log('producto')
    try {

        const productos = await pool.query('SELECT * FROM seleccionar_productos()');
      
        res.json(productos.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoParroquiasGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_parroquias()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoProveedorGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_proveedor()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoAñejamientoGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_añejamiento()');
        console.log(productos.rows)
        res.json(productos.rows);   
        
    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoCategoriaGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_categoria()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoVariedadGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_variedad()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoSaborGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_sabor()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoColorGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_color()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoMateriaGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_materia()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoImagenGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_imagen()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};

const productoPresentacionGet = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_presentacion()');
        res.json(productos.rows);   

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }
    
};



const productoByProveedor = async(req = request, res = response) => {
    try {
        const { proveedor } = req.query;
        console.log('estoy recibiendo esto this.proveedor')
        console.log(proveedor)
        const productos = await pool.query('SELECT * FROM obtener_productos_por_proveedor($1)', [proveedor]);
        res.json(productos.rows);
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });
      }
    
};

const productoPost = async (req = request, res = response) => {
    const {
        nombre,
        descripcion,
        gradosa,
        tipo,
        anejamiento,
        proveedor,
        parroquia,
        categoria,
        variedad,
        sabor,
        color,
        materiaPrima,
        imagenes,
        presentaciones
    } = req.body;

    console.log(req.body);

    try {
        
        const dbresponse = await pool.query('SELECT public.registrar_producto($1, $2, $3, $4, $5, $6, $7, $8, $9)', [
            nombre,
            descripcion,
            gradosa,
            tipo,
            anejamiento,
            proveedor,
            parroquia,
            categoria,
            variedad
        ]);
        
        // Obtener el ID del producto registrado
        const productId = await buscarElUltimoProducto();
        console.log(productId);

        
        await pool.query('SELECT public.insertar_sabores($1, $2)', [productId, sabor]);

        await pool.query('SELECT public.insertar_colores($1, $2)', [productId, color]);

        await pool.query('SELECT public.insertar_materia($1, $2)', [productId, materiaPrima]);

        await pool.query('SELECT public.insertar_presentacion($1, $2)', [productId, presentaciones]);

        await pool.query('SELECT public.insertar_imagen($1, $2)', [productId, imagenes]);

       // await pool.query('SELECT public.insertar_presentacion($1, $2)', [productId, presentaciones]);

        // Confirmar la transacción
        await pool.query('COMMIT');

        res.json({ id: productId });
    } catch (error) {
        // Revertir la transacción en caso de error
        await pool.query('ROLLBACK');
        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    } 
};



const buscarElUltimoProducto = async (req, res = response) => {
    try {
        const result = await pool.query('SELECT MAX(pro_codigo) FROM "Producto"');
        // Obtener el valor máximo de la respuesta
        const maxCodigo = result.rows[0].max;
        return maxCodigo;
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
};

const productoPut = async(req, res = response) => {

    const {
        id,
        nombre,
        descripcion,
        gradosa,
        tipo,
        anejamiento,
        proveedor,
        parroquia,
        categoria,
        variedad,
        sabor,
        color,
        materiaPrima,
        imagen,
        presentaciones
    } = req.body;

    console.log(req.body);
    console.log('estoy recibiendo esto', anejamiento)

    try{

        const dbresponse = await pool.query('SELECT public.modificar_producto($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)', 
        [
            id,
            nombre,
            descripcion,
            gradosa,
            tipo,
            anejamiento,
            proveedor,
            parroquia,
            categoria,
            variedad
        ]);

        await pool.query('SELECT public.actualizar_sabores($1, $2)', [id, sabor]);
        await pool.query('SELECT public.actualizar_colores($1, $2)', [id, color]);
        await pool.query('SELECT public.actualizar_materia($1, $2)', [id, materiaPrima]);
        await pool.query('SELECT public.actualizar_imagen($1, $2)', [id, imagen]);
        await pool.query('SELECT public.actualizar_presentacion($1, $2)', [id, presentaciones]);


        res.json(' solicitud recibida ');

    } catch(error) {
            
            console.error(error);
            res.status(500).json({ error: 'Error interno del servidor' });
    }
}



const productoDelete = async(req, res = response) => {
   
    const codigo = req.params.codigo;

    try{

        const dbresponse = await pool.query('SELECT eliminar_producto($1)', [codigo]);
        res.json(' solicitud recibida ');

    }catch(error) {

        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });

    }
    

}


const presentacionByProveedor = async(req = request, res = response) => {
    try {
        const { proveedor } = req.query;
        const productos = await pool.query('SELECT * FROM obtener_presentaciones_por_proveedor($1)', [proveedor]);
        res.json(productos.rows);
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error interno del servidor' });
      }
    
};
const productoGetById = async(req = request, res = response) => {

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_productos_por_id($1)', [req.body.id]);
        console.log(productos.rows)
        res.json(productos.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const detalleGetById = async(req = request, res = response) => {
console.log(req.body)
    try {

        const productos = await pool.query('SELECT(public.detalleproducto($1)).*', [req.body.id]);
        console.log(productos.rows)
        res.json(productos.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};

const pagar = async(req = request, res = response) => {
    console.log(req.body)
    try {
        console.log(req.body)
        const productos = await pool.query('SELECT public.pagar_venta_virtual($1,$2,$3,$4,$5,$6,$7)',[req.body.cod1,req.body.cod2, req.body.montos, req.body.tarjetas,req.body.cant_elementos,req.body.cuota,req.body.cod_venta]);
        console.log(productos.rows)
        res.json(productos.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const crearOrden = async(req = request, res = response) => {
    console.log(req.body)
    try {
        console.log(req.body)
        const orden = await pool.query('CALL public.crear_orden($1, $2,$3, $4)',[req.body.cod1,req.body.cod2, req.body.presentacion,req.body.cantidad]);
        console.log(orden.rows)
        res.json(orden.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const mostrarCarrito = async(req = request, res = response) => {
    console.log(req.body)
    try {
        console.log(req.body)
        const carrito = await pool.query('SELECT (public.carrito($1,$2,$3)).*',[req.body.cod1,req.body.cod2,req.body.estatus]);
        console.log(carrito.rows)
        res.json(carrito.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const fechaFactura = async(req = request, res = response) => {
    console.log(req.body)
    try {
        console.log(req.body)
        const factura = await pool.query('SELECT public.fecha_factura_virtual($1)',[req.body.cod]);
        console.log(factura.rows)
        res.json(factura.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const datosFactura = async(req = request, res = response) => {
    console.log(req.body)
    try {
        console.log(req.body)
        const factura = await pool.query('SELECT( public.datos_factura_venta_virtual($1,$2)).*',[req.body.cod1,req.body.cod2]);
        console.log(factura.rows)
        res.json(factura.rows);   
        

    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const productopostById = async(req = request, res = response) => {

    const { id } = req.body;

    try {

        const productos = await pool.query('SELECT * FROM seleccionar_productos_id($1)', [id]);

        res.json(productos.rows);
        
    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

};
const productoById = async(req = request, res = response) => {

    const { id } = req.body;

    try {

        const productos = await pool.query('SELECT (public.seleccionar_productos_id($1)).*', [id]);

        res.json(productos.rows);
        
    } catch (error) {

        console.error('Error al ejecutar la consulta:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
            
    }

}









export{
    productoGet,
    productoPost,
    productoPut,
    productoDelete,
    productoByProveedor,
    presentacionByProveedor,
    productoParroquiasGet,
    productoProveedorGet,
    productoAñejamientoGet,
    productoCategoriaGet,
    productoVariedadGet,
    productoSaborGet,
    productoColorGet,
    productoMateriaGet,
    productoImagenGet,
    productoPresentacionGet,
    productoGetById,
    detalleGetById,
    pagar,
    crearOrden,
    mostrarCarrito,
    fechaFactura,
    datosFactura,
    productopostById,
    productoById
}