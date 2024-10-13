use axum::{routing::get, Router};
use dotenv::dotenv;
use std::net::SocketAddr;
use tokio_postgres::NoTls;
use tower::ServiceBuilder;

mod handlers;
mod models;

#[tokio::main]
async fn main() {
    dotenv().ok();

    // Connect to the database
    let (db_client, connection) = tokio_postgres::connect(
        &std::env::var("DATABASE_URL").expect("DATABASE_URL not set"),
        NoTls,
    )
    .await
    .expect("Failed to connect to the database");

    // Spawn the connection handler in a separate task
    tokio::spawn(async move {
        if let Err(e) = connection.await {
            eprintln!("Database connection error: {}", e);
        }
    });

    // Create the app router
    let app = Router::new()
        .route("/user/:username", get(handlers::get_user))
        .route("/settings", get(handlers::get_settings).put(handlers::update_settings))
        .layer(ServiceBuilder::new().layer(axum::extract::Extension(db_client.clone())));

    let addr = SocketAddr::from(([0, 0, 0, 0], 8001));
    println!("Server running at http://{}", addr);
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}
