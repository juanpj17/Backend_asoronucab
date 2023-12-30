import { Router } from 'express';
import { rolesGet, rolesPost, rolesPut, rolesDelete } from '../controllers/roles-control.js';

export const routerRoles = Router();

routerRoles.get('/', rolesGet);

routerRoles.put('/', rolesPut)

routerRoles.post('/', rolesPost)

routerRoles.delete('/', rolesDelete)