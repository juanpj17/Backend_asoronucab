import { Router } from 'express';
import { productoGet, 
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
        productopostById,
        productoById
    } from '../controllers/producto-control.js';

export const routerProducto = Router();

routerProducto.get('/', productoGet);
routerProducto.get('/parroquias', productoParroquiasGet);
routerProducto.get('/proveedor', productoProveedorGet);
routerProducto.get('/anejamiento', productoAñejamientoGet);
routerProducto.get('/categoria', productoCategoriaGet);
routerProducto.get('/variedad', productoVariedadGet);
routerProducto.get('/sabor', productoSaborGet);
routerProducto.get('/color', productoColorGet);
routerProducto.get('/materia', productoMateriaGet);
routerProducto.get('/imagen', productoImagenGet);
routerProducto.get('/presentacion', productoPresentacionGet);


routerProducto.put('/', productoPut)

routerProducto.post('/', productoPost)

routerProducto.delete('/:codigo', productoDelete)

routerProducto.get('/proveedor', productoByProveedor)

routerProducto.get('/proveedor/presentacion', presentacionByProveedor)
routerProducto.post('/productoId', productoGetById)
routerProducto.post('/detalle', detalleGetById )
routerProducto.post('/pagar', pagar )
routerProducto.post('/crearOrden', crearOrden )
routerProducto.post('/carrito', mostrarCarrito )
routerProducto.post('/fecha', fechaFactura )
routerProducto.post('/modificar', productoPut)
routerProducto.post('/presentacionId', presentacionByProveedor)
routerProducto.post('/id',productoById )