import { Router } from 'express';
import {puntoGet } from '../controllers/punto-control.js';

export const routerPunto = Router();

routerPunto.get('/', puntoGet);