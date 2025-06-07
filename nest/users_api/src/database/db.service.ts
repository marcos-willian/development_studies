import { User } from "./models/user.model";

export const DbServiceToken = Symbol("DbService");

export interface DbService {
  getById(id: string): Promise<User | null>;
  getByEmail(email: string): Promise<User | null>;
  save(obj: Pick<User, "name" | "email" | "pass">): Promise<User>;
  edit(obj: User): Promise<User>;
}
