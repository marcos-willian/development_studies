import { IsEmail, IsNotEmpty } from "class-validator";
import { ValidPassword } from "./custom.validators";

export class PostSingupDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @ValidPassword()
  pass: string;

  @IsNotEmpty()
  name: string;
}
