import { Router } from 'express';
import {buscarUsuario,insertarAuditoria,buscarAuditoria } from '../controllers/usuario-control.js';

export const routerUsuario = Router();
routerUsuario.get('/Auditoria', buscarAuditoria);
routerUsuario.get('/:correo/:contrase', buscarUsuario);
routerUsuario.post('/insertarAuditoria', insertarAuditoria);
