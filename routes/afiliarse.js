import { Router } from 'express';
import { afiliarse } from '../controllers/afiliarse-control.js';

export const routerAfiliarse = Router();


routerAfiliarse.post('/', afiliarse)

