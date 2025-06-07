import { Global, Module } from "@nestjs/common";
import { DbServiceImpl } from "./db_impl.service";
import { DbServiceToken } from "./db.service";

@Global()
@Module({
  imports: [],
  controllers: [],
  providers: [
    {
      provide: DbServiceToken,
      useClass: DbServiceImpl,
    },
  ],
  exports: [DbServiceToken],
})
export class DbModule {}
