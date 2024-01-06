import { Router } from 'express';
import { tiendaFisicaGet, tiendaFisicaPost, tiendaFisicaPut, tiendaFisicaDelete , traerNamePost, 
        valorPuntoGet, tiendaFisicaSolaPost, validarTipoCheque, validarTipoEfectivo, procesarPago,
        procesarPagoE, procesarPagoT, procesarDetalleE, actualizar, obtenerEntradas, detalleE, 
        actualizarEntrada, procesarPagoP, procesarPagoEntradaC, procesarPagoEntrada, procesarPagoEntradaP,
        procesarPagoEntradaT, tiendaFisicaPresentacion, procesarDetalleT, actualizarInventarioTienda,
        mostrarFactura} from '../controllers/tiendaFisica-control.js';

export const routerTiendaFisica = Router();

routerTiendaFisica.get('/', tiendaFisicaGet);

routerTiendaFisica.put('/', tiendaFisicaPut)

routerTiendaFisica.post('/', tiendaFisicaPost)

routerTiendaFisica.delete('/', tiendaFisicaDelete)

routerTiendaFisica.post('/particular', traerNamePost)

routerTiendaFisica.post('/sola', tiendaFisicaSolaPost)

routerTiendaFisica.get('/punto', valorPuntoGet)

routerTiendaFisica.post('/validarCheques', validarTipoCheque)

routerTiendaFisica.post('/validarEfectivo', validarTipoEfectivo)

routerTiendaFisica.post('/procesarPago', procesarPago)

routerTiendaFisica.post('/procesarPagoE', procesarPagoE)

routerTiendaFisica.post('/procesarPagoT', procesarPagoT)

routerTiendaFisica.post('/procesarDetalleE', procesarDetalleE)

routerTiendaFisica.post('/actualizar', actualizar)

routerTiendaFisica.post('/entradasDisponibles', obtenerEntradas)

routerTiendaFisica.post('/detalleE', detalleE)

routerTiendaFisica.post('/actualizarEntrada', actualizarEntrada)

routerTiendaFisica.post('/procesarPagoP', procesarPagoP)

routerTiendaFisica.post('/procesarPagoEntradaC', procesarPagoEntradaC)

routerTiendaFisica.post('/procesarPagoEntradaE', procesarPagoEntrada)

routerTiendaFisica.post('/procesarPagoEntradaP', procesarPagoEntradaP)

routerTiendaFisica.post('/procesarPagoEntradaT', procesarPagoEntradaT)

routerTiendaFisica.post('/factura', mostrarFactura)

routerTiendaFisica.post('/tienda', tiendaFisicaPresentacion)

routerTiendaFisica.post('/detalleTienda', procesarDetalleT)

routerTiendaFisica.post('/actualizarInvTienda', actualizarInventarioTienda)