import { Router } from 'express';
import { entradaGet, entradaPost, entradaPut, entradaDelete, calculoPost , entradasPost
} from '../controllers/entrada-control.js';

export const routerEntrada = Router();

routerEntrada.get('/', entradaGet);

routerEntrada.put('/', entradaPut)

routerEntrada.post('/', entradaPost)

routerEntrada.delete('/', entradaDelete)

routerEntrada.post('/calculo', calculoPost)

routerEntrada.post('/entradaPrecio', entradasPost)
