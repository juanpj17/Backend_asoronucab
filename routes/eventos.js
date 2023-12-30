import { Router } from 'express';
import { eventoGet, eventoPost, eventoPut, eventoDelete } from '../controllers/evento-control.js';

export const routerEvento = Router();

routerEvento.get('/', eventoGet);

routerEvento.put('/', eventoPut)

routerEvento.post('/', eventoPost)

routerEvento.delete('/', eventoDelete)