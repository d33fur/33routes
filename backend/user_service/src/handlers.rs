use axum::{
    extract::{Path, Query},
    http::StatusCode,
    response::Json,
    Extension,
};
use serde_json::json;
use tokio_postgres::Client;

use crate::models::{Settings, User};

pub async fn get_user(
    Path(username): Path<String>,
    Extension(db_client): Extension<Client>,
) -> Result<Json<User>, StatusCode> {
    let row = db_client
        .query_one(
            "SELECT * FROM users WHERE username = $1 AND is_deleted = false",
            &[&username],
        )
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    let user = User {
        user_id: row.get("user_id"),
        username: row.get("username"),
        name: row.get("name"),
        surname: row.get("surname"),
        country: row.get("country"),
        city: row.get("city"),
        email: row.get("email"),
        avatar_url: row.get("avatar_url"),
        bio: row.get("bio"),
        phone: row.get("phone"),
        created_at: row.get("created_at"),
        is_deleted: row.get("is_deleted"),
        instagram: row.get("instagram"),
        facebook: row.get("facebook"),
        x: row.get("x"),
        vkontakte: row.get("vkontakte"),
        telegram: row.get("telegram"),
        linkedin: row.get("linkedin"),
        youtube: row.get("youtube"),
        user_site: row.get("user_site"),
        email_for_communications: row.get("email_for_communications"),
    };

    Ok(Json(user))
}

pub async fn get_settings(
    Extension(db_client): Extension<Client>,
) -> Result<Json<Settings>, StatusCode> {
    let row = db_client
        .query_one(
            "SELECT theme, show_phone, show_planned, show_visited, show_favorite FROM user_settings WHERE user_id = 1",
            &[],
        )
        .await
        .map_err(|_| StatusCode::NOT_FOUND)?;

    let settings = Settings {
        theme: row.get("theme"),
        show_phone: row.get("show_phone"),
        show_planned: row.get("show_planned"),
        show_visited: row.get("show_visited"),
        show_favorite: row.get("show_favorite"),
    };

    Ok(Json(settings))
}

pub async fn update_settings(
    Json(payload): Json<Settings>,
    Extension(db_client): Extension<Client>,
) -> Result<StatusCode, StatusCode> {
    db_client
        .execute(
            "UPDATE user_settings SET theme = $1, show_phone = $2, show_planned = $3, show_visited = $4, show_favorite = $5 WHERE user_id = 1",
            &[&payload.theme, &payload.show_phone, &payload.show_planned, &payload.show_visited, &payload.show_favorite],
        )
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

    Ok(StatusCode::OK)
}
