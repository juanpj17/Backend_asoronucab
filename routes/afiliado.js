import { Router } from 'express';
import { buscarDatosCarnet,pagarCuotaAfiliacion } from '../controllers//afiliado-control.js';

export const routerAfiliado = Router();


routerAfiliado.get('/:codigo_tipo_registro', buscarDatosCarnet)
routerAfiliado.post('/', pagarCuotaAfiliacion)


