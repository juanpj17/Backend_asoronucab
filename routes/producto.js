import { Router } from 'express';
import { productoGet, productoPost, productoPut, productoDelete, productoByProveedor } from '../controllers/producto-control.js';

export const routerProducto = Router();

routerProducto.get('/', productoGet);

routerProducto.put('/', productoPut)

routerProducto.post('/', productoPost)

routerProducto.delete('/', productoDelete)

routerProducto.get('/proveedor', productoByProveedor)