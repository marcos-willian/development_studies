import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from "@nestjs/common";
import { DbService } from "./db.service";
import { User } from "./models/user.model";

@Injectable()
export class DbServiceImpl implements DbService {
  private static users: Array<User> = [];

  getByEmail(email: string): Promise<User | null> {
    const user =
      DbServiceImpl.users.find((user) => user.email === email) ?? null;
    return Promise.resolve(user);
  }

  getById(id: string): Promise<User | null> {
    const user = DbServiceImpl.users.find((user) => user.id === id) ?? null;
    return Promise.resolve(user);
  }
  async save(obj: Pick<User, "name" | "email" | "pass">): Promise<User> {
    const user =
      DbServiceImpl.users.find((user) => user.email === obj.email) ?? null;
    if (user) throw new ForbiddenException();

    const newUser: User = {
      id: (DbServiceImpl.users.length + 1).toString(),
      email: obj.email,
      pass: obj.pass,
      created_at: new Date(Date.now()),
      updated_at: new Date(Date.now()),
      name: obj.name,
    };

    DbServiceImpl.users.push(newUser);

    const { pass: _, ...userWithoutPass } = newUser;
    return Promise.resolve(userWithoutPass as User);
  }
  edit(obj: User): Promise<User> {
    const user = DbServiceImpl.users.find((user) => user.id === obj.id) ?? null;
    if (!user) throw new NotFoundException();

    DbServiceImpl.users[DbServiceImpl.users.indexOf(user)] = obj;

    return Promise.resolve(obj);
  }
}
