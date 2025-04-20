import { Router } from "express";
import {SettingsController} from "./controller/SettingsController"

/**==============================================
 * *                   Tipos de parametros
 *   Routes Params =>  http://localhost:3333/1
 * 
 *   Query Params => http://localhost:3333/1?search=algo
 *   
 *   Body Params => JSON
 *
 *=============================================**/

const routes = Router();
const settingsController = new SettingsController();
routes.post("/settings", settingsController.create);
export {routes};