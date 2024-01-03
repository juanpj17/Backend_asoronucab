import { Router } from 'express';
import { eventoGet, eventoPost, eventoPut, eventoDelete, eventoHora, presentacionEvento, ultimoEventoGet, consultarEvento, lugarEvento, fk_presentacionEvento, nombreEvento } from '../controllers/evento-control.js';

export const routerEvento = Router();

routerEvento.get('/', eventoGet);

routerEvento.put('/', eventoPut)

routerEvento.post('/', eventoPost)

routerEvento.delete('/', eventoDelete)

routerEvento.get('/actual', eventoHora)

routerEvento.post('/actual', presentacionEvento)

routerEvento.get('/ultimo', ultimoEventoGet)

routerEvento.post('/consultar', consultarEvento)

routerEvento.post('/lugar', lugarEvento)

routerEvento.post('/presentacion', fk_presentacionEvento)

routerEvento.post('/nombre', nombreEvento)

