DROP DATABASE IF EXISTS balancebuddy;

CREATE DATABASE IF NOT EXISTS balancebuddy;
USE balancebuddy;

-- Table: Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(100),
    demographic VARCHAR(100)
);

-- Table: Clients
CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    contact VARCHAR(100),
    dietary_preferences TEXT,
    health_goal TEXT,
    dietary_restrictions TEXT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) -- Optional, if Clients are also Users
);

-- Table: Nutritionists
CREATE TABLE Nutritionists (
    nutritionist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact VARCHAR(100)
);

-- Table: Audiences
CREATE TABLE Audiences (
    audience_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    interest VARCHAR(100),
    age_range VARCHAR(50),
    budget DECIMAL(10,2)
);

-- Table: Advertisers
CREATE TABLE Advertisers (
    advertiser_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    payment_info TEXT
);

-- Table: Ads
CREATE TABLE Ads (
    ad_id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255),
    start_date DATE,
    end_date DATE,
    name VARCHAR(100),
    budget DECIMAL(10,2),
    caption TEXT,
    advertiser_id INT,
    FOREIGN KEY (advertiser_id) REFERENCES Advertisers(advertiser_id)
);

-- Table: Engagement
CREATE TABLE Engagement (
    engagement_id INT AUTO_INCREMENT PRIMARY KEY,
    feedback TEXT,
    count INT,
    ad_id INT,
    FOREIGN KEY (ad_id) REFERENCES Ads(ad_id)
);

-- Table: Market_Research
CREATE TABLE Market_Research (
    research_id INT AUTO_INCREMENT PRIMARY KEY,
    findings TEXT,
    trends TEXT,
    competition TEXT,
    advertiser_id INT,
    FOREIGN KEY (advertiser_id) REFERENCES Advertisers(advertiser_id)
);

-- Table: User_Client (many-to-many relationship between Users and Clients)
CREATE TABLE User_Client (
    user_id INT,
    client_id INT,
    PRIMARY KEY (user_id, client_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: User_Nutritionist (many-to-many relationship between Users and Nutritionists)
CREATE TABLE User_Nutritionist (
    user_id INT,
    nutritionist_id INT,
    PRIMARY KEY (user_id, nutritionist_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (nutritionist_id) REFERENCES Nutritionists(nutritionist_id)
);

-- Table: User_Audience (many-to-many relationship between Users and Audiences)
CREATE TABLE User_Audience (
    user_id INT,
    audience_id INT,
    PRIMARY KEY (user_id, audience_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (audience_id) REFERENCES Audiences(audience_id)
);

-- Table: Food_Log
CREATE TABLE Food_Log (
    food_log_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    meal_type VARCHAR(50),
    comments TEXT,
    food_items TEXT,
    calories DECIMAL(10,2),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: Vitamins_Minerals (many-to-many relationship with Food_Log)
CREATE TABLE Vitamins_Minerals (
    food_log_id INT,
    quantity DECIMAL(10,2),
    mineral_type VARCHAR(100),
    vitamin_type VARCHAR(100),
    PRIMARY KEY (food_log_id, mineral_type, vitamin_type),
    FOREIGN KEY (food_log_id) REFERENCES Food_Log(food_log_id)
);

-- Table: Schedule
CREATE TABLE Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    calendar DATE,
    time_of_day TIME,
    food_timeline TEXT,
    hours INT,
    exercise_time_line TEXT,
    day_of_week VARCHAR(20),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: Exercise_Info
CREATE TABLE Exercise_Info (
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    breaths_per_minute DECIMAL(5,2),
    BMI DECIMAL(5,2),
    weight DECIMAL(5,2),
    height DECIMAL(5,2),
    max_HR INT,
    exercise_pages TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Table: Report
CREATE TABLE Report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    progress_summary TEXT,
    report_date DATE,
    recommendation TEXT,
    text TEXT,
    date DATE,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: Communication
CREATE TABLE Communication (
    communication_id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    date DATE,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: Meal_Plan
CREATE TABLE Meal_Plan (
    meal_plan_id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT,
    nutrition_info TEXT,
    ingredients TEXT,
    updated_date DATE,
    created_at DATE,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Table: Audience_Engagement (many-to-many relationship between Audiences and Engagements)
CREATE TABLE Audience_Engagement (
    audience_id INT,
    engagement_id INT,
    PRIMARY KEY (audience_id, engagement_id),
    FOREIGN KEY (audience_id) REFERENCES Audiences(audience_id),
    FOREIGN KEY (engagement_id) REFERENCES Engagement(engagement_id)
);