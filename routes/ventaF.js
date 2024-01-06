import { Router } from 'express';
import { ventaFGet, ventaFPost,ventaFPut, ventaFDelete,
        ventaFInsertar, entradaInserta, tarjetaObtener,
        ocultarNumeros, actualizarPuntos, tarjetaObtenerJ, actualizarPuntosJ
 } from '../controllers/ventaF-control.js';

export const routerVentaFisica = Router();

routerVentaFisica.get('/', ventaFGet);

routerVentaFisica.put('/', ventaFPut)

routerVentaFisica.post('/', ventaFPost)

routerVentaFisica.delete('/', ventaFDelete)

routerVentaFisica.post('/insertarE', ventaFInsertar)

routerVentaFisica.post('/entrada', entradaInserta)

routerVentaFisica.post('/tarjetasObtener', tarjetaObtener)

routerVentaFisica.post('/ocultar', ocultarNumeros)

routerVentaFisica.post('/actualizarPuntos', actualizarPuntos)

routerVentaFisica.post('/tarjetasObtenerJ', tarjetaObtenerJ)

routerVentaFisica.post('/actualizarPuntosJ', actualizarPuntosJ)
