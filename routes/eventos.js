import { Router } from 'express';
import { eventoGet, eventoPost, eventoPut, eventoDelete, eventoHora, presentacionEvento, ultimoEventoGet } from '../controllers/evento-control.js';

export const routerEvento = Router();

routerEvento.get('/', eventoGet);

routerEvento.put('/', eventoPut)

routerEvento.post('/', eventoPost)

routerEvento.delete('/', eventoDelete)

routerEvento.get('/actual', eventoHora)

routerEvento.post('/actual', presentacionEvento)

routerEvento.get('/ultimo', ultimoEventoGet)