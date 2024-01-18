import { Router } from 'express';
import {  ofertaPost, ofertaGet } from '../controllers/diario-control.js';

export const routerDiario = Router();


routerDiario.post('/', ofertaPost)
routerDiario.get('/', ofertaGet)

