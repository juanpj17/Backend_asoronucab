import { Router } from 'express';
import { eventoGet, eventoPost, eventoPut, eventoDelete, eventoHora, presentacionEvento, ultimoEventoGet, consultarEvento, lugarEvento, fk_presentacionEvento, nombreEvento,insertarNotaCata,obtenerPremios,obtenerPresentaciones,insertarPremio } from '../controllers/evento-control.js';

export const routerEvento = Router();

routerEvento.get('/', eventoGet);
routerEvento.get('/obtenerPremios', obtenerPremios)

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
routerEvento.post('/notaCata', insertarNotaCata)
routerEvento.post('/presentacionesProducto',obtenerPresentaciones)
routerEvento.post('/premio',insertarPremio)
