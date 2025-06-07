import { IsEmail, IsNotEmpty } from "class-validator";

export class PostLoginDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  pass: string;
}
