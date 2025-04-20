import {Request,Response} from "express"
import { getCustomRepository } from "typeorm";
import { settingsRepository } from "../repositories/settingsRepository";

class SettingsController {
    async create(req : Request, res : Response){
        const {chat, username} = req.body;
        const repository = getCustomRepository(settingsRepository);
        const settings = repository.create({
            chat,
            username
        });
    
        await repository.save(settings)
        .then(settings =>{
            res.json(settings)
        })
        .catch(err =>{
            res.json(err);
        })
    }
}
export { SettingsController}