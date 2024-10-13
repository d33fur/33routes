use axum::{
    extract::State,
    http::StatusCode,
    Json,
};
use sqlx::PgPool;
use bcrypt::{hash, verify};
use uuid::Uuid;

use crate::models::{RegisterUser, RegisterResponse, UsernameCheck, LoginUser, LoginResponse};

pub async fn register(
    State(pool): State<PgPool>,
    Json(payload): Json<RegisterUser>,
) -> Result<(StatusCode, Json<RegisterResponse>), StatusCode> {
    let hashed_password = hash(&payload.password, 4).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    let result = sqlx::query!(
        r#"
        INSERT INTO users (username, name, surname, email, password_hash, phone, created_at, is_deleted)
        VALUES ($1, $2, $3, $4, $5, $6, EXTRACT(EPOCH FROM NOW())::BIGINT, FALSE)
        RETURNING user_id
        "#,
        payload.username,
        payload.name,
        payload.surname,
        payload.email,
        hashed_password,
        payload.phone,
    )
    .fetch_one(&pool)
    .await;

    match result {
        Ok(record) => {
            let token = Uuid::new_v4().to_string();

            Ok((StatusCode::CREATED, Json(RegisterResponse {
                user_id: record.user_id,
                token,
            })))
        }
        Err(sqlx::Error::Database(e)) if e.constraint().unwrap_or("") == "users_email_key" => {
            Err(StatusCode::CONFLICT)
        }
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn check_username(
    State(pool): State<PgPool>,
    Json(payload): Json<UsernameCheck>,
) -> Result<StatusCode, StatusCode> {
    let result = sqlx::query!(
        r#"SELECT COUNT(username) FROM users WHERE username = $1"#,
        payload.username
    )
    .fetch_optional(&pool)
    .await;

    match result {
        Ok(None) => Ok(StatusCode::OK),
        Ok(Some(_)) => Err(StatusCode::CONFLICT),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn login(
    State(pool): State<PgPool>,
    Json(payload): Json<LoginUser>,
) -> Result<(StatusCode, Json<LoginResponse>), StatusCode> {
    let user = sqlx::query!(
        r#"
        SELECT user_id, password_hash FROM users WHERE email = $1
        "#,
        payload.email
    )
    .fetch_optional(&pool)
    .await
    .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    if let Some(record) = user {
        if verify(&payload.password, &record.password_hash).map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)? {
            let token = Uuid::new_v4().to_string();
            let refresh_token = Uuid::new_v4().to_string();

            Ok((StatusCode::OK, Json(LoginResponse {
                token,
                refresh_token,
            })))
        } else {
            Err(StatusCode::UNAUTHORIZED)
        }
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}
