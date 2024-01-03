import { Router } from 'express';
import {buscarUsuario } from '../controllers/usuario-control.js';

export const routerUsuario = Router();

routerUsuario.get('/:correo/:contrase', buscarUsuario);