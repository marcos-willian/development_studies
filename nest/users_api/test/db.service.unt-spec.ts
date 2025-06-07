import { ForbiddenException } from "@nestjs/common";
import { DbService } from "../src/database/db.service";
import { DbServiceImpl } from "../src/database/db_impl.service";

describe("Db Service Test", () => {
  let dbService: DbService;

  beforeEach(() => {
    dbService = new DbServiceImpl();
  });

  it("Should save the 3 users diferent and should get by email", async () => {
    const user1 = {
      email: "1",
      pass: "2",
      name: "1",
    };

    await dbService.save(user1);
    const user2 = {
      email: "2",
      pass: "2",
      name: "2",
    };

    await dbService.save(user2);
    const user3 = {
      email: "3",
      pass: "2",
      name: "3",
    };

    await dbService.save(user3);

    const user = await dbService.getByEmail(user3.email);

    expect(user?.email).toBe(user3.email);
  });
  it("Should throw exception to try save 2 equally user", async () => {
    const user1 = {
      email: "7",
      pass: "2",
      name: "1",
    };

    await dbService.save(user1);
    await expect(dbService.save(user1)).rejects.toThrow(ForbiddenException);
  });
});
