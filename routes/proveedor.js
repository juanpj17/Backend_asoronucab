import { Router } from 'express';
import { proveedorGet, proveedorPost, proveedorPut, proveedorDelete } from '../controllers/proveedor-control.js';

export const routerProveedor = Router();

routerProveedor.get('/', proveedorGet);

routerProveedor.put('/', proveedorPut)

routerProveedor.post('/', proveedorPost)

routerProveedor.delete('/', proveedorDelete)
