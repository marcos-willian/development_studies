import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication, ValidationPipe } from "@nestjs/common";
import * as request from "supertest";
import { App } from "supertest/types";
import { AppModule } from "../src/app.module";
import { User } from "src/database/models/user.model";
import { PostSingupDto } from "src/auth/dto/post_singup.dto";
import { PostLoginDto } from "src/auth/dto/post_login.dto";

describe("AppController (e2e)", () => {
  let app: INestApplication<App>;
  let accessToken: string;

  const userInfo: User = {
    id: "",
    email: "test@test.com",
    pass: "tm1~!",
    name: "test",
    created_at: new Date(),
    updated_at: new Date(),
  };

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(new ValidationPipe());
    await app.init();
  });
  afterAll(async () => {
    await app.close();
  });

  it("health check", () => {
    return request(app.getHttpServer())
      .get("/health")
      .expect(200)
      .expect("Working!");
  });

  describe("Auth", () => {
    describe("singup", () => {
      it("Should return 400 for email empty", () => {
        return request(app.getHttpServer())
          .post("/auth/singup")
          .send({
            pass: userInfo.pass,
            name: userInfo.name,
          })
          .expect(400);
      });
      it("Should return 400 for pass empty", () => {
        return request(app.getHttpServer())
          .post("/auth/singup")
          .send({
            email: userInfo.email,
            name: userInfo.name,
          })
          .expect(400);
      });
      it("Should return 400 for name empty", () => {
        return request(app.getHttpServer())
          .post("/auth/singup")
          .send({
            email: userInfo.email,
            pass: userInfo.pass,
          })
          .expect(400);
      });
      it("Should return 400 for invalid email", () => {
        return request(app.getHttpServer())
          .post("/auth/singup")
          .send({
            email: "teest.com",
            pass: userInfo.pass,
            name: userInfo.name,
          })
          .expect(400);
      });
      it("Should return 400 for invalid pass", () => {
        return request(app.getHttpServer())
          .post("/auth/singup")
          .send({
            email: userInfo.email,
            pass: "t1a",
            name: userInfo.name,
          })
          .expect(400);
      });
      it("Should return 201 for valid", () => {
        const singupDto: PostSingupDto = userInfo;

        return request(app.getHttpServer())
          .post("/auth/singup")
          .send(singupDto)
          .expect(201);
      });
    });
    describe("login", () => {
      it("Should return 400 for email empty", () => {
        return request(app.getHttpServer())
          .post("/auth/login")
          .send({
            pass: userInfo.pass,
          })
          .expect(400);
      });
      it("Should return 400 for pass empty", () => {
        return request(app.getHttpServer())
          .post("/auth/login")
          .send({
            email: userInfo.email,
          })
          .expect(400);
      });
      it("Should return 401 for invalid credentials", () => {
        return request(app.getHttpServer())
          .post("/auth/login")
          .send({
            email: userInfo.email,
            pass: "t1!",
          })
          .expect(401);
      });
      it("Should return 201 for valid login", async () => {
        const loginDto: PostLoginDto = { ...userInfo };
        const response = await request(app.getHttpServer())
          .post("/auth/login")
          .send(loginDto)
          .expect(201);

        expect(response.body).toHaveProperty("access_token");
        const { access_token } = response.body as { access_token: string };
        accessToken = access_token;
      });
    });
  });

  describe("Users", () => {
    it("Should receive 401 if doents send accessToken", () => {
      return request(app.getHttpServer()).get("/user").expect(401);
    });
    it("Should receive 200 in normal conditions", async () => {
      const response = await request(app.getHttpServer())
        .get("/user")
        .set("Authorization", `Bearer ${accessToken}`)
        .expect(200);
      expect(response.body).toHaveProperty("email");
      const { email } = response.body as { email: string };
      expect(email).toBe(userInfo.email);
    });
  });
});
