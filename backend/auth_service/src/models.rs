use serde::{Deserialize, Serialize};

#[derive(Deserialize)]
pub struct RegisterUser {
    pub email: String,
    pub password: String,
    pub name: String,
    pub surname: String,
    pub username: String,
    pub phone: String,
}

#[derive(Serialize)]
pub struct RegisterResponse {
    pub user_id: i32,
    pub token: String,
}

#[derive(Deserialize)]
pub struct UsernameCheck {
    pub username: String,
}

#[derive(Deserialize)]
pub struct LoginUser {
    pub email: String,
    pub password: String,
}

#[derive(Serialize)]
pub struct LoginResponse {
    pub token: String,
    pub refresh_token: String,
}
