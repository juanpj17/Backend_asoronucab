import { Router } from 'express';
import { clienteGet, clientePost, clientePut, clienteDelete } from '../controllers/cliente-control.js';

export const routerCliente = Router();

routerCliente.get('/', clienteGet);

routerCliente.put('/', clientePut)

routerCliente.post('/', clientePost)

routerCliente.delete('/', clienteDelete)
