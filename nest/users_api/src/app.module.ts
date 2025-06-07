import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AuthModule } from "./auth/auth.module";
import { DbModule } from "./database/db.module";
import { JwtModule } from "@nestjs/jwt";
import { UsersModule } from "./users/users.module";

@Module({
  imports: [
    AuthModule,
    DbModule,
    UsersModule,
    JwtModule.register({
      global: true,
      secret: "test",
    }),
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}
