import { Router } from 'express';
import {ordenesActivas ,datosOrdenCompra,direccionProveedor,fechaOrden,ordenes,actualizar} from '../controllers/ordenReposicion-control.js';

export const routerOrdenReposicion = Router();

routerOrdenReposicion.get('/',ordenesActivas);
routerOrdenReposicion.post('/',datosOrdenCompra);
routerOrdenReposicion.post('/proveedor',direccionProveedor);
routerOrdenReposicion.post('/fecha',fechaOrden);
routerOrdenReposicion.post('/actualizar',actualizar);

routerOrdenReposicion.get('/orden',ordenes);