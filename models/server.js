import express from 'express';
import cors from 'cors';

import { routerAfiliarse } from '../routes/afiliarse.js';
import { routerCliente } from '../routes/cliente.js';
import { routerEmpleado } from '../routes/empleado.js';
import { routerEntrada } from '../routes/entrada.js';
import { routerEvento } from '../routes/eventos.js';
import { routerFacturaAfiliado } from '../routes/facturaAfiliado.js';
import { routerParroquia } from '../routes/parroquia.js';
import { routerProducto } from '../routes/producto.js';
import { routerProveedor } from '../routes/proveedor.js';
import { routerPunto } from '../routes/punto.js';
import { routerRoles } from '../routes/roles.js';
import { routerTelefono } from '../routes/telefono.js';
import { routerTiendaFisica } from '../routes/tienda-fisica.js';
import { routerUsuario } from '../routes/usuario.js';
import { routerVentaFisica } from '../routes/ventaF.js';
import {routerAfiliado} from '../routes/afiliado.js';
import {routerTasa} from '../routes/tasa.js';


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
            afiliadoPath:'/api/afiliado',
            afiliarsePath:'/api/afiliarse',
            clientePath: '/api/cliente',
            empleadoPath: '/api/empleado',
            entradaPath:'/api/entrada',
            eventoPath: '/api/evento',
            facturaAfiliado:'/api/facturaAfiliado',
            parroquiaPath: '/api/parroquia',
            productoPath: '/api/producto',
            proveedorPath: '/api/proveedor',
            puntoPath:'/api/punto',
            rolesPath: '/api/roles',
            tasaPath:'/api/tasa',
            telefonoPath:'/api/telefono',
            tiendafisicaPath: '/api/tiendafisica',
            usuarioPath:'/api/usuario',
            ventaFPath:'/api/ventaF'
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
        this.app.use(this.path.afiliadoPath,routerAfiliado);
        this.app.use(this.path.afiliarsePath,routerAfiliarse);
        this.app.use(this.path.clientePath, routerCliente);
        this.app.use(this.path.empleadoPath, routerEmpleado);
        this.app.use(this.path.entradaPath, routerEntrada);
        this.app.use(this.path.eventoPath, routerEvento);
        this.app.use(this.path.facturaAfiliado,routerFacturaAfiliado);
        this.app.use(this.path.parroquiaPath, routerParroquia);
        this.app.use(this.path.productoPath, routerProducto);
        this.app.use(this.path.proveedorPath, routerProveedor);
        this.app.use(this.path.puntoPath,routerPunto);
        this.app.use(this.path.rolesPath, routerRoles);
        this.app.use(this.path.tasaPath,routerTasa);
        this.app.use(this.path.telefonoPath, routerTelefono);
        this.app.use(this.path.tiendafisicaPath, routerTiendaFisica);
        this.app.use(this.path.usuarioPath,routerUsuario);
        this.app.use(this.path.ventaFPath, routerVentaFisica);
        
    }
}

export { Server, pool };