import { Router } from 'express';
import { tiendaFisicaGet, tiendaFisicaPost, tiendaFisicaPut, tiendaFisicaDelete , traerNamePost, tiendaFisicaSolaPost} from '../controllers/tiendaFisica-control.js';

export const routerTiendaFisica = Router();

routerTiendaFisica.get('/', tiendaFisicaGet);

routerTiendaFisica.put('/', tiendaFisicaPut)

routerTiendaFisica.post('/', tiendaFisicaPost)

routerTiendaFisica.delete('/', tiendaFisicaDelete)

routerTiendaFisica.post('/particular', traerNamePost)

routerTiendaFisica.post('/sola', tiendaFisicaSolaPost)
