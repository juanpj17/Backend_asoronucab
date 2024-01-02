import { Router } from 'express';
import { clienteGet, clientePost, clientePut, clienteDelete, clienteGetN ,clientePutN, clientePostN, 
    clienteDeleteN , clienteGetJ ,clientePutJ, clientePostJ, clienteDeleteJ , telefonoClienteN, 
    modificarClienteN, modificarUsuario, consultarClienteJ, buscarCorreoN, consultarUsuario,
    modificarCorreo
} from '../controllers/cliente-control.js';

export const routerCliente = Router();

routerCliente.get('/', clienteGet);

routerCliente.put('/', clientePut)

routerCliente.post('/', clientePost)

routerCliente.delete('/', clienteDelete)

// routerCliente.get('/naturalllllll', clienteGetN);

routerCliente.put('/natural', clientePutN)

routerCliente.post('/natural', clientePostN)

routerCliente.delete('/natural', clienteDeleteN)

routerCliente.get('/juridico', clienteGetJ);

routerCliente.put('/juridico', clientePutJ)

routerCliente.post('/juridico', clientePostJ)

routerCliente.delete('/juridico', clienteDeleteJ)

routerCliente.post('/natural1', clienteGetN);

routerCliente.post('/telefono', telefonoClienteN);

routerCliente.put('/modificarclienteN', modificarClienteN)

routerCliente.put('/modificarusuarioN', modificarUsuario)

routerCliente.post('/consultarJ', consultarClienteJ)

routerCliente.post('/correoN', buscarCorreoN)

routerCliente.post('/usuarioN', consultarUsuario)

routerCliente.put('/correoNatural', modificarCorreo)

