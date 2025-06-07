import { Body, Controller, Post } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { PostSingupDto } from "./dto/post_singup.dto";
import { PostLoginDto } from "./dto/post_login.dto";

@Controller("/auth")
export class AuthController {
  constructor(private service: AuthService) {}

  @Post("/login")
  login(@Body() params: PostLoginDto) {
    return this.service.login(params);
  }

  @Post("/singup")
  singup(@Body() params: PostSingupDto) {
    return this.service.singup(params);
  }
}
