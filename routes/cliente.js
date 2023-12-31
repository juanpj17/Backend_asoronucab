import { Router } from 'express';
import { clienteGet, clientePost, clientePut, clienteDelete, clienteGetN ,clientePutN, clientePostN, clienteDeleteN , clienteGetJ ,clientePutJ, clientePostJ, clienteDeleteJ } from '../controllers/cliente-control.js';

export const routerCliente = Router();

routerCliente.get('/', clienteGet);

routerCliente.put('/', clientePut)

routerCliente.post('/', clientePost)

routerCliente.delete('/', clienteDelete)

routerCliente.get('/natural', clienteGetN);

routerCliente.put('/natural', clientePutN)

routerCliente.post('/natural', clientePostN)

routerCliente.delete('/natural', clienteDeleteN)

routerCliente.get('/juridico', clienteGetJ);

routerCliente.put('/juridico', clientePutJ)

routerCliente.post('/juridico', clientePostJ)

routerCliente.delete('/juridico', clienteDeleteJ)