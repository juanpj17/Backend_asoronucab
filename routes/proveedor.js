import { Router } from 'express';
import { proveedorGet, proveedorPost, proveedorPut, proveedorDelete, presentacionesxProveedor } from '../controllers/proveedor-control.js';

export const routerProveedor = Router();

routerProveedor.get('/', proveedorGet);

routerProveedor.put('/', proveedorPut)

routerProveedor.post('/', proveedorPost)

routerProveedor.delete('/', proveedorDelete)

routerProveedor.post('/Pxp', presentacionesxProveedor)