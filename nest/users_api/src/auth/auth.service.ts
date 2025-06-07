import { Inject, Injectable, UnauthorizedException } from "@nestjs/common";
import { PostSingupDto } from "./dto/post_singup.dto";
import { PostLoginDto } from "./dto/post_login.dto";
import { DbService, DbServiceToken } from "../database/db.service";
import * as argon2 from "argon2";
import { JwtService } from "@nestjs/jwt";
import { JwtPayload } from "./dto/jws_payload.dto";

@Injectable()
export class AuthService {
  constructor(
    @Inject(DbServiceToken)
    private db: DbService,
    private jwtService: JwtService,
  ) {}

  async login(params: PostLoginDto) {
    const user = await this.db.getByEmail(params.email);
    if (!user) throw new UnauthorizedException("Credentials invalid");

    const validPass = await argon2.verify(user.pass, params.pass);

    if (!validPass) throw new UnauthorizedException("Credentials invalid");

    const payload: JwtPayload = {
      sub: user.id,
      email: user.email,
      name: user.name,
    };

    return {
      access_token: await this.jwtService.signAsync(payload),
    };
  }

  async singup(params: PostSingupDto) {
    return this.db.save({
      pass: await argon2.hash(params.pass),
      email: params.email,
      name: params.name,
    });
  }
}
