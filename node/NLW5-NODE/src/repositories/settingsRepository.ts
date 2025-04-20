import { EntityRepository, Repository } from "typeorm";
import { settings } from "../entities/settings";

@EntityRepository(settings)
class settingsRepository extends Repository<settings>{

}

export {settingsRepository}