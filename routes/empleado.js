import { Router } from 'express';
import { empleadoGet, empleadoPost, empleadoPut, empleadoDelete, consultarEmpleado, consultarUsuario, 
    modificarUsuario, modificarEmpleado, telefonoEmpleado, consultarTelefonoEmpleado, consultarCorreoEmpleado,
    modificarCorreo
    } from '../controllers/empleado-control.js';

export const routerEmpleado = Router();

routerEmpleado.get('/', empleadoGet);

routerEmpleado.put('/', empleadoPut);

routerEmpleado.post('/', empleadoPost);

routerEmpleado.delete('/:cedula', empleadoDelete);

routerEmpleado.post('/consultar', consultarEmpleado)

routerEmpleado.post('/usuario', consultarUsuario);

routerEmpleado.put('/modificarUsuario', modificarUsuario);

routerEmpleado.put('/modificar', modificarEmpleado);

routerEmpleado.post('/telefono', telefonoEmpleado);

routerEmpleado.post('/consultartelefono', consultarTelefonoEmpleado);

routerEmpleado.post('/consultarcorreo', consultarCorreoEmpleado);

routerEmpleado.put('/correo', modificarCorreo);