import express from 'express';
import cors from 'cors';
import { routerEmpleado } from '../routes/empleado.js';
import { routerCliente } from '../routes/cliente.js';
import { routerEvento } from '../routes/eventos.js';
import { routerParroquia } from '../routes/parroquia.js';
import { routerProveedor } from '../routes/proveedor.js';
import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
    host: 'localhost',
    port: '5432',
    database: 'Asoron',
    user: 'postgres',
    password: '414Margarita'
});



class Server {
    constructor(){
        this.port = process.env.SERVER_PORT || 3000;
        this.app = express();
        this.path = {
            empleadoPath: '/api/empleado',
            clientePath: '/api/cliente',
            eventoPath: '/api/evento',
            parroquiaPath: '/api/parroquia',
            proveedorPath: '/api/proveedor',
        };
        this.pool = pool;

        // Middlewares
        this.middlewares();
        // Rutas de mi aplicacion
        this.routes();
    }

    listen(){
        this.app.listen(this.port, () => {
            console.log(`Corriendo en el puerto ${this.port}`)
        })
    }

    middlewares(){
        // Cors 
        this.app.use(cors());
        
        //Lectura y parseo de body
        this.app.use( express.json() );

    }

    routes(){
        this.app.use(this.path.proveedorPath, routerProveedor);
        this.app.use(this.path.parroquiaPath, routerParroquia);
        this.app.use(this.path.eventoPath, routerEvento);
        this.app.use(this.path.clientePath, routerCliente);
        this.app.use(this.path.empleadoPath, routerEmpleado);
    }
}

export { Server, pool };