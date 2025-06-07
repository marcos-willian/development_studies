import {
  registerDecorator,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from "class-validator";

@ValidatorConstraint({ name: "ValidPassword", async: false })
export class ValidPasswordConstraint implements ValidatorConstraintInterface {
  validate(value: any): boolean {
    return (
      typeof value === "string" &&
      /[0-9]/.test(value) &&
      /[a-zA-Z]/.test(value) &&
      /[^a-zA-Z0-9]/.test(value)
    );
  }

  defaultMessage(): string {
    return "Password invalid: It must have at least one number, one letter, and one special character.";
  }
}

// This is the decorator you use in the DTO
export function ValidPassword(validationOptions?: ValidationOptions) {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [],
      validator: ValidPasswordConstraint,
    });
  };
}
