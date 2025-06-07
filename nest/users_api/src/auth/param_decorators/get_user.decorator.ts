import { createParamDecorator, ExecutionContext } from "@nestjs/common";
import { JwtPayload } from "../dto/jws_payload.dto";
import { User } from "../../database/models/user.model";

export const GetUser = createParamDecorator(
  (
    data: string,
    ctx: ExecutionContext,
  ): Pick<User, "id" | "email" | "name"> => {
    const request: Request = ctx.switchToHttp().getRequest();
    const userPayload = request["user"] as JwtPayload;
    return {
      id: userPayload.sub,
      name: userPayload.name,
      email: userPayload.email,
    };
  },
);
