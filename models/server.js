import express from 'express';
import cors from 'cors';
import { router } from '../routes/empleado.js';
import { routerCliente } from '../routes/cliente.js';
import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_DATABASE,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

class Server {
    constructor(){
        this.port = process.env.SERVER_PORT || 3000;
        this.app = express();
        this.path = {
            empleadoPath: '/api/empleado',
            clientePath: '/api/cliente'
        };
        this.pool = pool;

        // Middlewares
        this.middlewares();
        // Rutas de mi aplicacion
        this.routes();
    }

    async listen(){
        try{
            await this.pool.connect();
            console.log("Conexión exitosa");
        }catch(err){
            console.log(err);
        }
    }

    server_listen(){
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
        this.app.use(this.path.clientePath, routerCliente);
        this.app.use(this.path.empleadoPath, router);
    }
}

export { Server, pool };