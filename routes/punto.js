import { Router } from 'express';
import {puntoGet,ventaPunto } from '../controllers/punto-control.js';

export const routerPunto = Router();

routerPunto.get('/', puntoGet);
routerPunto.get('/venta', ventaPunto);