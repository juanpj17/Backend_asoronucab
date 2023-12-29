import { Router } from 'express';
import { userGet, userPost, userPut, userDelete } from '../controllers/empleado-control.js';

export const router = Router();

router.get('/', userGet);

router.put('/', userPut)

router.post('/', userPost)

router.delete('/', userDelete)

