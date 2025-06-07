import { Controller, Get, Body, Patch, Param, UseGuards } from "@nestjs/common";
import { UsersService } from "./users.service";
import { UpdateUserDto } from "./dto/update-user.dto";
import { AuthGuard } from "../auth/guad/auth.guard";
import { GetUser } from "../auth/param_decorators/get_user.decorator";
import { User } from "../database/models/user.model";

@Controller("user")
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(AuthGuard)
  @Get()
  get(@GetUser() user: User) {
    return user;
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(+id, updateUserDto);
  }
}
