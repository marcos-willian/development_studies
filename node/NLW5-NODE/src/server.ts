import express from "express";
import "./database/index.ts";
import {routes} from "./routes"

const server = express();

/**----------------------------------------------
 *                Metodos HTTP's
 *  GET = Buscas
 *  POST = Criação
 *  PUT = Alteração 
 *  DELETE = Deletar
 *  PATCH =Alterar um informação
 *---------------------------------------------**/

server.use(express.json());
server.use(routes);
server.listen(3333, () => console.log("Server is running on port 3333"));