import { Router } from 'express';
import { graficar, graficarVentas, graficarTres, tablaColumna1, tablaColumna2, graficarOrdenes, columnaCuatro } from '../controllers/grafico-control.js';

export const routerGrafico = Router();


routerGrafico.post('/', graficar)
routerGrafico.get('/', graficarVentas)
routerGrafico.post('/tercera', graficarTres)
routerGrafico.post('/columnaUno', tablaColumna1)
routerGrafico.post('/columnaDos', tablaColumna2)
routerGrafico.post('/ordenes', graficarOrdenes)
routerGrafico.post('/columnaCuatro', columnaCuatro)
