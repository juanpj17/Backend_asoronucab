import { Router } from 'express';
import { telefonoGet, telefonoPost,telefonoPut, telefonoDelete,
    eliminarNumerosEmpleado, eliminarNumerosCliente
 } from '../controllers/telefono-control.js';

export const routerTelefono = Router();

routerTelefono.get('/', telefonoGet);

routerTelefono.put('/', telefonoPut)

routerTelefono.post('/', telefonoPost)

routerTelefono.delete('/', telefonoDelete)

routerTelefono.delete('/empleado', eliminarNumerosEmpleado)

routerTelefono.delete('/clienteN', eliminarNumerosCliente)
