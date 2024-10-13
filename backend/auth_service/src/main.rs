use axum::{routing::post, Router};
use sqlx::PgPool;
use std::env;
use dotenv::dotenv;
use redis::Client;

mod models;
mod handlers;

#[tokio::main]
async fn main() {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let pool = PgPool::connect(&database_url)
        .await
        .expect("Could not connect to database");

    let redis_url = env::var("REDIS_URL").expect("REDIS_URL must be set");
    let redis_client = Client::open(redis_url).expect("Could not connect to Redis");

    let app = Router::new()
        .route("/auth/register", post(handlers::register))
        .route("/auth/valid/username", post(handlers::check_username))
        .route("/auth/login", post(handlers::login))
        .with_state(pool)
        .with_state(redis_client);

    axum::Server::bind(&"0.0.0.0:8001".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
