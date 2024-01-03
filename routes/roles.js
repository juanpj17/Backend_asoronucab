import { Router } from 'express';
import { rolesGet, rolesPost,obtenerRolId,modificarRol,eliminarRol,buscarPermisos,asignarPermisos ,buscarPermisosRol,eliminarPermisosRol} from '../controllers/roles-control.js';

export const routerRoles = Router();

routerRoles.get('/', rolesGet);
routerRoles.get('/permisos', buscarPermisos);
routerRoles.post('/asignarPermisos', asignarPermisos);
routerRoles.post('/rolPermisos', buscarPermisosRol);
routerRoles.post('/eliminarRolPermisos',eliminarPermisosRol);
routerRoles.post('/', rolesPost)
routerRoles.post('/id', obtenerRolId)
routerRoles.post('/modificar',modificarRol )
routerRoles.post('/eliminar', eliminarRol)

