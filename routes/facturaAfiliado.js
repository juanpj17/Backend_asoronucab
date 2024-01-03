import { Router } from 'express';
import {DatosFactura,DatosAfiliado,DatosAsoron } from '../controllers/facturaAfiliado-control.js';

export const routerFacturaAfiliado = Router();



routerFacturaAfiliado.post('/', DatosFactura)
routerFacturaAfiliado.post('/datosAfiliado', DatosAfiliado)
routerFacturaAfiliado.post('/datosAsoron', DatosAsoron)