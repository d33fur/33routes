use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserProfile {
    pub user_id: u64,
    pub username: String,
    pub name: String,
    pub surname: String,
    pub country: Option<String>,
    pub city: Option<String>,
    pub avatar_url: Option<String>,
    pub bio: Option<String>,
    pub created_at: u64,
    pub links: UserLinks,
    pub collections_made_by_user: CollectionsInfo,
    pub routes_made_by_user: RoutesInfo,
    pub visited_routes: VisitedRoutesInfo,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserLinks {
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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CollectionsInfo {
    pub amount: u32,
    pub collections: Vec<Collection>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Collection {
    pub id: u64,
    pub likes: u32,
    pub comments: u32,
    pub views: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RoutesInfo {
    pub amount: u32,
    pub routes: Vec<Route>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Route {
    pub id: u64,
    pub likes: u32,
    pub reviews: u32,
    pub views: u32,
    pub rating: f32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VisitedRoutesInfo {
    pub amount: u32,
    pub routes: Vec<VisitedRoute>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VisitedRoute {
    pub id: u64,
    pub visited_date: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UserSettings {
    pub name: String,
    pub surname: String,
    pub username: String,
    pub email: String,
    pub phone: String,
    pub country: Option<String>,
    pub city: Option<String>,
    pub avatar_url: Option<String>,
    pub bio: Option<String>,
    pub theme: String,
    pub links: UserLinks,
    pub privacy_settings: PrivacySettings,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PrivacySettings {
    pub show_email_for_communications: bool,
    pub show_visited: bool,
    pub show_phone: bool,
    pub show_planned: bool,
    pub show_favorite: bool,
}
