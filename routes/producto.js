import { Router } from 'express';
import { productoGet, productoPost, productoPut, productoDelete, productoByProveedor, presentacionByProveedor,productoParroquiasGet, productoProveedorGet} from '../controllers/producto-control.js';

export const routerProducto = Router();

routerProducto.get('/', productoGet);

routerProducto.get('/parroquias', productoParroquiasGet);

routerProducto.get('/proveedor', productoProveedorGet);


routerProducto.put('/', productoPut)

routerProducto.post('/', productoPost)

routerProducto.delete('/:codigo', productoDelete)

routerProducto.get('/proveedor', productoByProveedor)

routerProducto.get('/proveedor/presentacion', presentacionByProveedor)