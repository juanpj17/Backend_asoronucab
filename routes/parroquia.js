import { Router } from 'express';
import { parroquiaGet, parroquiaPost,parroquiaPut, parroquiaDelete } from '../controllers/parroquia-control.js';

export const routerParroquia = Router();

routerParroquia.get('/', parroquiaGet);

routerParroquia.put('/', parroquiaPut)

routerParroquia.post('/', parroquiaPost)

routerParroquia.delete('/', parroquiaDelete)
