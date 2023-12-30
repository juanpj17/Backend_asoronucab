import { Router } from 'express';
import { empleadoGet, empleadoPost, empleadoPut, empleadoDelete } from '../controllers/empleado-control.js';

export const routerEmpleado = Router();

routerEmpleado.get('/', empleadoGet);

routerEmpleado.put('/', empleadoPut);

routerEmpleado.post('/', empleadoPost);

routerEmpleado.delete('/:cedula', empleadoDelete);

