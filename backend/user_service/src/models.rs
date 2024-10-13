use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct User {
    pub user_id: i32,
    pub username: String,
    pub name: String,
    pub surname: Option<String>,
    pub country: Option<String>,
    pub city: Option<String>,
    pub email: String,
    pub avatar_url: Option<String>,
    pub bio: Option<String>,
    pub phone: Option<String>,
    pub created_at: i64,
    pub is_deleted: bool,
    pub instagram: Option<String>,
    pub facebook: Option<String>,
    pub x: Option<String>,
    pub vkontakte: Option<String>,
    pub telegram: Option<String>,
    pub linkedin: Option<String>,
    pub youtube: Option<String>,
    pub user_site: Option<String>,
    pub email_for_communications: Option<String>,
}

#[derive(Serialize, Deserialize)]
pub struct Settings {
    pub theme: String,
    pub show_phone: bool,
    pub show_planned: bool,
    pub show_visited: bool,
    pub show_favorite: bool,
}
