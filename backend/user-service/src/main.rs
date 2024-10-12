use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use warp::{http::StatusCode, Filter};
use serde_json::Value;

mod models;
use models::{UserProfile, UserSettings};

#[tokio::main]
async fn main() {
    let db: Arc<Mutex<HashMap<String, UserProfile>>> = Arc::new(Mutex::new(HashMap::new()));
    let settings_db: Arc<Mutex<HashMap<String, UserSettings>>> = Arc::new(Mutex::new(HashMap::new()));

    let db_filter = warp::any().map(move || db.clone());
    let settings_db_filter = warp::any().map(move || settings_db.clone());

    // Route for GET /user/:username
    let get_user = warp::path!("user" / String)
        .and(warp::get())
        .and(db_filter.clone())
        .and_then(get_user_profile);

    // Route for GET /settings
    let get_settings = warp::path("settings")
        .and(warp::get())
        .and(warp::header::<String>("authorization"))
        .and(settings_db_filter.clone())
        .and_then(get_user_settings);

    // Route for PUT /settings
    let update_settings = warp::path("settings")
        .and(warp::put())
        .and(warp::header::<String>("authorization"))
        .and(warp::body::json())
        .and(settings_db_filter.clone())
        .and_then(update_user_settings);

    let routes = get_user.or(get_settings).or(update_settings);

    warp::serve(routes).run(([127, 0, 0, 1], 3030)).await;
}

async fn get_user_profile(
    username: String,
    db: Arc<Mutex<HashMap<String, UserProfile>>>
) -> Result<impl warp::Reply, warp::Rejection> {
    let db = db.lock().unwrap();
    if let Some(profile) = db.get(&username) {
        Ok(warp::reply::json(&profile))
    } else {
        Err(warp::reject::not_found())
    }
}

async fn get_user_settings(
    auth_token: String,
    db: Arc<Mutex<HashMap<String, UserSettings>>>
) -> Result<impl warp::Reply, warp::Rejection> {
    let username = extract_username_from_token(auth_token)?;
    let db = db.lock().unwrap();
    if let Some(settings) = db.get(&username) {
        Ok(warp::reply::json(&settings))
    } else {
        Err(warp::reject::not_found())
    }
}

async fn update_user_settings(
    auth_token: String,
    updated_data: Value,
    db: Arc<Mutex<HashMap<String, UserSettings>>>
) -> Result<impl warp::Reply, warp::Rejection> {
    let username = extract_username_from_token(auth_token)?;
    let mut db = db.lock().unwrap();
    if let Some(settings) = db.get_mut(&username) {
        if let Some(new_bio) = updated_data.get("bio").and_then(|v| v.as_str()) {
            settings.bio = Some(new_bio.to_string());
        }
        Ok(warp::reply::with_status("Settings updated", StatusCode::OK))
    } else {
        Err(warp::reject::not_found())
    }
}

fn extract_username_from_token(token: String) -> Result<String, warp::Rejection> {
    // Временно вернем фиктивное имя пользователя
    Ok("johndoe".to_string())
}
