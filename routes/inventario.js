import { Router } from 'express';
import { 
    generarReporteCompra, 
    generarReporteVenta,
    generarReporteVentaFisica,
    generarReporteVentaFisicaEvento
} from '../controllers/inventario-control.js';

export const routerInventario = Router();

routerInventario.get('/venta/:dato', generarReporteVenta)
routerInventario.get('/compra/:dato', generarReporteCompra)
routerInventario.get('/ventaFisica/:dato', generarReporteVentaFisica)
routerInventario.get('/ventaFisicaEvento/:dato', generarReporteVentaFisicaEvento)