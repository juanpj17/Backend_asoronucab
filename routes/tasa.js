import { Router } from 'express';
import {tasaGet } from '../controllers/tasa-control.js';

export const routerTasa = Router();

routerTasa.get('/', tasaGet);