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

insert into Users (username, email, name, demographic, user_id) values ('asecrett0', 'asecrett0@cisco.com', 'Aube Secrett', 'Sri Lankan', 1);
insert into Users (username, email, name, demographic, user_id) values ('ybaum1', 'ybaum1@ft.com', 'Yuri Baum', 'Alaskan Athabascan', 2);
insert into Users (username, email, name, demographic, user_id) values ('aperfect2', 'aperfect2@wikispaces.com', 'Adrienne Perfect', 'White', 3);
insert into Users (username, email, name, demographic, user_id) values ('vwallentin3', 'vwallentin3@state.gov', 'Valaree Wallentin', 'Colombian', 4);
insert into Users (username, email, name, demographic, user_id) values ('jjenner4', 'jjenner4@narod.ru', 'Jania Jenner', 'Yakama', 5);
insert into Users (username, email, name, demographic, user_id) values ('dpostance5', 'dpostance5@businesswire.com', 'Davis Postance', 'Comanche', 6);
insert into Users (username, email, name, demographic, user_id) values ('etaphouse6', 'etaphouse6@twitter.com', 'Ede Taphouse', 'Mexican', 7);
insert into Users (username, email, name, demographic, user_id) values ('bpenfold7', 'bpenfold7@ibm.com', 'Borg Penfold', 'Chippewa', 8);
insert into Users (username, email, name, demographic, user_id) values ('tkalderon8', 'tkalderon8@unc.edu', 'Theodoric Kalderon', 'Bolivian', 9);
insert into Users (username, email, name, demographic, user_id) values ('ycuddehy9', 'ycuddehy9@scribd.com', 'Yoshiko Cuddehy', 'Ute', 10);
insert into Users (username, email, name, demographic, user_id) values ('crenfortha', 'crenfortha@amazon.com', 'Claudius Renforth', 'Native Hawaiian', 11);
insert into Users (username, email, name, demographic, user_id) values ('edangerfieldb', 'edangerfieldb@noaa.gov', 'Eadie Dangerfield', 'Puget Sound Salish', 12);
insert into Users (username, email, name, demographic, user_id) values ('cclarricoatesc', 'cclarricoatesc@amazon.co.jp', 'Cleopatra Clarricoates', 'Shoshone', 13);
insert into Users (username, email, name, demographic, user_id) values ('eguidoned', 'eguidoned@domainmarket.com', 'Eloisa Guidone', 'Cambodian', 14);
insert into Users (username, email, name, demographic, user_id) values ('jglendenninge', 'jglendenninge@imdb.com', 'Jaclin Glendenning', 'Japanese', 15);
insert into Users (username, email, name, demographic, user_id) values ('bgumeyf', 'bgumeyf@tuttocitta.it', 'Bartlet Gumey', 'Argentinian', 16);
insert into Users (username, email, name, demographic, user_id) values ('vpeplawg', 'vpeplawg@sina.com.cn', 'Virgina Peplaw', 'Vietnamese', 17);
insert into Users (username, email, name, demographic, user_id) values ('oferschkeh', 'oferschkeh@bing.com', 'Odetta Ferschke', 'Comanche', 18);
insert into Users (username, email, name, demographic, user_id) values ('apoynteri', 'apoynteri@ameblo.jp', 'Ameline Poynter', 'Chinese', 19);
insert into Users (username, email, name, demographic, user_id) values ('mtewelsonj', 'mtewelsonj@over-blog.com', 'Mitch Tewelson', 'Polynesian', 20);
insert into Users (username, email, name, demographic, user_id) values ('cgierardik', 'cgierardik@rediff.com', 'Clerc Gierardi', 'Bangladeshi', 21);
insert into Users (username, email, name, demographic, user_id) values ('psmallpiecel', 'psmallpiecel@diigo.com', 'Peadar Smallpiece', 'Argentinian', 22);
insert into Users (username, email, name, demographic, user_id) values ('nlumsdainem', 'nlumsdainem@rediff.com', 'Nonnah Lumsdaine', 'Pakistani', 23);
insert into Users (username, email, name, demographic, user_id) values ('eamirandan', 'eamirandan@moonfruit.com', 'Elspeth Amiranda', 'Venezuelan', 24);
insert into Users (username, email, name, demographic, user_id) values ('mibbotto', 'mibbotto@e-recht24.de', 'Mela Ibbott', 'Chippewa', 25);
insert into Users (username, email, name, demographic, user_id) values ('rstammlerp', 'rstammlerp@europa.eu', 'Ryun Stammler', 'Paiute', 26);
insert into Users (username, email, name, demographic, user_id) values ('hrogeonq', 'hrogeonq@shareasale.com', 'Hattie Rogeon', 'White', 27);
insert into Users (username, email, name, demographic, user_id) values ('abolithor', 'abolithor@ycombinator.com', 'Ambur Bolitho', 'Choctaw', 28);
insert into Users (username, email, name, demographic, user_id) values ('jandreichiks', 'jandreichiks@mit.edu', 'Judon Andreichik', 'Menominee', 29);
insert into Users (username, email, name, demographic, user_id) values ('mtatumt', 'mtatumt@comsenz.com', 'Micaela Tatum', 'Asian', 30);
insert into Users (username, email, name, demographic, user_id) values ('rhamonu', 'rhamonu@123-reg.co.uk', 'Randell Hamon', 'Micronesian', 31);
insert into Users (username, email, name, demographic, user_id) values ('lcurtaynev', 'lcurtaynev@behance.net', 'Lisabeth Curtayne', 'Yakama', 32);
insert into Users (username, email, name, demographic, user_id) values ('ekhoterw', 'ekhoterw@time.com', 'Eduard Khoter', 'Colville', 33);
insert into Users (username, email, name, demographic, user_id) values ('wmcmychemx', 'wmcmychemx@ucsd.edu', 'Welsh McMychem', 'Ute', 34);
insert into Users (username, email, name, demographic, user_id) values ('ccrollmany', 'ccrollmany@bigcartel.com', 'Carlota Crollman', 'Cambodian', 35);

insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Buddie Pearn', 39, 'Male', 'bpearn0@patch.com', 1, 1, 'intermittent fasting', 'Vegan', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Pier Allum', 83, 'Female', 'pallum1@wikipedia.org', 2, 2, 'intermittent fasting', 'Flexitarian and Macrobiotic Diet', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Gustav Panas', 29, 'Male', 'gpanas2@latimes.com', 3, 3, 'No dairy', 'Vegetarian', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Milty Van Daalen', 75, 'Male', 'mvan3@berkeley.edu', 4, 4, 'No dairy', 'Pescatarian', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Parnell Eede', 12, 'Male', 'peede4@ifeng.com', 5, 5, 'intermittent fasting', 'Vegan', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Kendell Brigstock', 36, 'Male', 'kbrigstock5@homestead.com', 6, 6, 'No dairy', 'Pescatarian', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Janaye Benez', 65, 'Female', 'jbenez6@skype.com', 7, 7, 'Organic Foods', 'Vegetarian', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Betsey Roome', 68, 'Female', 'broome7@technorati.com', 8, 8, 'No dairy', 'Flexitarian and Macrobiotic Diet', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Renato Cureton', 76, 'Male', 'rcureton8@domainmarket.com', 9, 9, 'Organic Foods', 'Vegan', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Casar Draysay', 83, 'Male', 'cdraysay9@nih.gov', 10, 10, 'Organic Foods', 'Vegan', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Rik McMennum', 9, 'Male', 'rmcmennuma@shareasale.com', 11, 11, 'Organic Foods', 'Vegan', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Dorita Whifen', 76, 'Female', 'dwhifenb@zdnet.com', 12, 12, 'No dairy', 'Vegan', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Lawton Crayton', 68, 'Male', 'lcraytonc@loc.gov', 13, 13, 'Organic Foods', 'Flexitarian and Macrobiotic Diet', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Marin Clutram', 21, 'Female', 'mclutramd@qq.com', 14, 14, 'intermittent fasting', 'Vegan', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Donal Sheber', 77, 'Male', 'dshebere@plala.or.jp', 15, 15, 'intermittent fasting', 'Pescatarian', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Livvie Kollaschek', 66, 'Female', 'lkollaschekf@storify.com', 16, 16, 'intermittent fasting', 'Vegetarian', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Mohandas Oosthout de Vree', 36, 'Male', 'moosthoutg@gnu.org', 17, 17, 'No dairy', 'Vegetarian', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Leif McCoy', 33, 'Male', 'lmccoyh@netscape.com', 18, 18, 'No dairy', 'Vegetarian', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Tammy Pudney', 12, 'Female', 'tpudneyi@wsj.com', 19, 19, 'intermittent fasting', 'Pescatarian', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Amelia Bathoe', 26, 'Female', 'abathoej@ow.ly', 20, 20, 'Organic Foods', 'Flexitarian and Macrobiotic Diet', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Kennedy Mars', 24, 'Male', 'kmarsk@wunderground.com', 21, 21, 'No dairy', 'Vegan', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Jerrilyn Danzig', 5, 'Female', 'jdanzigl@instagram.com', 22, 22, 'intermittent fasting', 'Vegan', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Ramonda Hasell', 14, 'Female', 'rhasellm@myspace.com', 23, 23, 'intermittent fasting', 'Vegetarian', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Margarette Cufley', 12, 'Female', 'mcufleyn@yahoo.co.jp', 24, 24, 'Organic Foods', 'Flexitarian and Macrobiotic Diet', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Albertina Egar', 11, 'Female', 'aegaro@360.cn', 25, 25, 'intermittent fasting', 'Pescatarian', 'Lose Weight');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Zelig Howchin', 82, 'Male', 'zhowchinp@miitbeian.gov.cn', 26, 26, 'No dairy', 'Flexitarian and Macrobiotic Diet', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Letisha Sibray', 31, 'Female', 'lsibrayq@theguardian.com', 27, 27, 'No dairy', 'Vegetarian', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Fanchon Valek', 21, 'Female', 'fvalekr@51.la', 28, 28, 'intermittent fasting', 'Vegetarian', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Kalila Blackway', 43, 'Female', 'kblackways@ft.com', 29, 29, 'intermittent fasting', 'Pescatarian', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Gayle Mashal', 37, 'Female', 'gmashalt@creativecommons.org', 30, 30, 'No dairy', 'Flexitarian and Macrobiotic Diet', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Marcille Orman', 50, 'Female', 'mormanu@oracle.com', 31, 31, 'No dairy', 'Vegan', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Lori Maghull', 40, 'Female', 'lmaghullv@wsj.com', 32, 32, 'No dairy', 'Vegetarian', 'Gain Muscle');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Robinson Corryer', 21, 'Male', 'rcorryerw@imgur.com', 33, 33, 'No dairy', 'Pescatarian', 'More Confidence');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Sibelle Wherrit', 68, 'Female', 'swherritx@jugem.jp', 34, 34, 'No dairy', 'Vegetarian', 'Feel Strong');
insert into Clients (name, age, gender, contact, user_id, client_id, dietary_preferences, dietary_restrictions, health_goal) values ('Dom Brideau', 60, 'Male', 'dbrideauy@latimes.com', 35, 35, 'No dairy', 'Vegan', 'Gain Muscle');

insert into Nutritionists (nutritionist_id, name, contact) values (1, 'Brooks Guerola', 'bguerola0@dropbox.com');
insert into Nutritionists (nutritionist_id, name, contact) values (2, 'Doti Sjollema', 'dsjollema1@bloglovin.com');
insert into Nutritionists (nutritionist_id, name, contact) values (3, 'Diane Portwain', 'dportwain2@wunderground.com');
insert into Nutritionists (nutritionist_id, name, contact) values (4, 'Elbertina Pendleton', 'ependleton3@deliciousdays.com');
insert into Nutritionists (nutritionist_id, name, contact) values (5, 'Redd Harbach', 'rharbach4@cyberchimps.com');
insert into Nutritionists (nutritionist_id, name, contact) values (6, 'Cort Clegg', 'cclegg5@elpais.com');
insert into Nutritionists (nutritionist_id, name, contact) values (7, 'Giusto Veschambes', 'gveschambes6@marriott.com');
insert into Nutritionists (nutritionist_id, name, contact) values (8, 'Keith Franc', 'kfranc7@guardian.co.uk');
insert into Nutritionists (nutritionist_id, name, contact) values (9, 'Melodie Savege', 'msavege8@bloomberg.com');
insert into Nutritionists (nutritionist_id, name, contact) values (10, 'Yulma Rustedge', 'yrustedge9@mozilla.com');
insert into Nutritionists (nutritionist_id, name, contact) values (11, 'Vicky Chipman', 'vchipmana@imageshack.us');
insert into Nutritionists (nutritionist_id, name, contact) values (12, 'Caren Trudgion', 'ctrudgionb@studiopress.com');
insert into Nutritionists (nutritionist_id, name, contact) values (13, 'Keelby Dudin', 'kdudinc@businesswire.com');
insert into Nutritionists (nutritionist_id, name, contact) values (14, 'Janek Macia', 'jmaciad@homestead.com');
insert into Nutritionists (nutritionist_id, name, contact) values (15, 'Donny Whittington', 'dwhittingtone@lulu.com');
insert into Nutritionists (nutritionist_id, name, contact) values (16, 'Heida Kellog', 'hkellogf@freewebs.com');
insert into Nutritionists (nutritionist_id, name, contact) values (17, 'Madge Gretham', 'mgrethamg@mediafire.com');
insert into Nutritionists (nutritionist_id, name, contact) values (18, 'Sebastien Presnail', 'spresnailh@google.com');
insert into Nutritionists (nutritionist_id, name, contact) values (19, 'Ansell Giocannoni', 'agiocannonii@diigo.com');
insert into Nutritionists (nutritionist_id, name, contact) values (20, 'Terrie Bradtke', 'tbradtkej@ted.com');
insert into Nutritionists (nutritionist_id, name, contact) values (21, 'Stephanie Neesham', 'sneeshamk@reverbnation.com');
insert into Nutritionists (nutritionist_id, name, contact) values (22, 'Laney Arkil', 'larkill@technorati.com');
insert into Nutritionists (nutritionist_id, name, contact) values (23, 'Basia Garrold', 'bgarroldm@w3.org');
insert into Nutritionists (nutritionist_id, name, contact) values (24, 'Cleveland McAuliffe', 'cmcauliffen@mail.ru');
insert into Nutritionists (nutritionist_id, name, contact) values (25, 'Bethena Scutcheon', 'bscutcheono@msu.edu');
insert into Nutritionists (nutritionist_id, name, contact) values (26, 'Alexia Collerd', 'acollerdp@theglobeandmail.com');
insert into Nutritionists (nutritionist_id, name, contact) values (27, 'Ulrikaumeko Blaycock', 'ublaycockq@businesswire.com');
insert into Nutritionists (nutritionist_id, name, contact) values (28, 'Lexine Ferry', 'lferryr@yellowpages.com');
insert into Nutritionists (nutritionist_id, name, contact) values (29, 'Faun Foye', 'ffoyes@joomla.org');
insert into Nutritionists (nutritionist_id, name, contact) values (30, 'Jobyna Seargeant', 'jseargeantt@csmonitor.com');
insert into Nutritionists (nutritionist_id, name, contact) values (31, 'Chas Meric', 'cmericu@nymag.com');
insert into Nutritionists (nutritionist_id, name, contact) values (32, 'Addi Arlett', 'aarlettv@gizmodo.com');
insert into Nutritionists (nutritionist_id, name, contact) values (33, 'Tymon Chantrell', 'tchantrellw@feedburner.com');
insert into Nutritionists (nutritionist_id, name, contact) values (34, 'Livia Halvosen', 'lhalvosenx@java.com');
insert into Nutritionists (nutritionist_id, name, contact) values (35, 'Rosana Darter', 'rdartery@mayoclinic.com');
insert into Nutritionists (nutritionist_id, name, contact) values (36, 'Bjorn Burlingame', 'bburlingamez@psu.edu');
insert into Nutritionists (nutritionist_id, name, contact) values (37, 'Alisun Barrell', 'abarrell10@techcrunch.com');
insert into Nutritionists (nutritionist_id, name, contact) values (38, 'Imelda Earthfield', 'iearthfield11@sakura.ne.jp');
insert into Nutritionists (nutritionist_id, name, contact) values (39, 'Madelin McGaughay', 'mmcgaughay12@yellowbook.com');
insert into Nutritionists (nutritionist_id, name, contact) values (40, 'Reinald Skillitt', 'rskillitt13@godaddy.com');
insert into Nutritionists (nutritionist_id, name, contact) values (41, 'Niels Phettiplace', 'nphettiplace14@wp.com');
insert into Nutritionists (nutritionist_id, name, contact) values (42, 'Vanna Farra', 'vfarra15@ebay.com');
insert into Nutritionists (nutritionist_id, name, contact) values (43, 'Clementia Memory', 'cmemory16@istockphoto.com');
insert into Nutritionists (nutritionist_id, name, contact) values (44, 'Ari Poe', 'apoe17@cbc.ca');
insert into Nutritionists (nutritionist_id, name, contact) values (45, 'Krystyna Ebbotts', 'kebbotts18@hatena.ne.jp');
insert into Nutritionists (nutritionist_id, name, contact) values (46, 'Pauletta Pluvier', 'ppluvier19@usda.gov');
insert into Nutritionists (nutritionist_id, name, contact) values (47, 'Town Blum', 'tblum1a@multiply.com');
insert into Nutritionists (nutritionist_id, name, contact) values (48, 'Julee Weddeburn - Scrimgeour', 'jweddeburn1b@go.com');
insert into Nutritionists (nutritionist_id, name, contact) values (49, 'Dasya Boulger', 'dboulger1c@springer.com');
insert into Nutritionists (nutritionist_id, name, contact) values (50, 'Miguel Morse', 'mmorse1d@netvibes.com');
insert into Nutritionists (nutritionist_id, name, contact) values (51, 'Kearney Jaggli', 'kjaggli1e@bravesites.com');
insert into Nutritionists (nutritionist_id, name, contact) values (52, 'Rosalind Vannacci', 'rvannacci1f@dmoz.org');
insert into Nutritionists (nutritionist_id, name, contact) values (53, 'Marabel Bemrose', 'mbemrose1g@typepad.com');
insert into Nutritionists (nutritionist_id, name, contact) values (54, 'Jason Calley', 'jcalley1h@forbes.com');
insert into Nutritionists (nutritionist_id, name, contact) values (55, 'Debera Choldcroft', 'dcholdcroft1i@simplemachines.org');
insert into Nutritionists (nutritionist_id, name, contact) values (56, 'Stanwood Schurcke', 'sschurcke1j@reverbnation.com');
insert into Nutritionists (nutritionist_id, name, contact) values (57, 'Hildagarde Bamb', 'hbamb1k@linkedin.com');
insert into Nutritionists (nutritionist_id, name, contact) values (58, 'Lucita Hammel', 'lhammel1l@apache.org');
insert into Nutritionists (nutritionist_id, name, contact) values (59, 'Gordon Pennigar', 'gpennigar1m@twitter.com');
insert into Nutritionists (nutritionist_id, name, contact) values (60, 'Siegfried McCarter', 'smccarter1n@vistaprint.com');
insert into Nutritionists (nutritionist_id, name, contact) values (61, 'Alisha Ardron', 'aardron1o@networkadvertising.org');
insert into Nutritionists (nutritionist_id, name, contact) values (62, 'Baxie Zwicker', 'bzwicker1p@cargocollective.com');
insert into Nutritionists (nutritionist_id, name, contact) values (63, 'Ber Linfitt', 'blinfitt1q@unblog.fr');
insert into Nutritionists (nutritionist_id, name, contact) values (64, 'Bryn Hayford', 'bhayford1r@unesco.org');
insert into Nutritionists (nutritionist_id, name, contact) values (65, 'Erina Bugdale', 'ebugdale1s@state.gov');
insert into Nutritionists (nutritionist_id, name, contact) values (66, 'Padgett Comley', 'pcomley1t@indiegogo.com');
insert into Nutritionists (nutritionist_id, name, contact) values (67, 'Chrysa Polin', 'cpolin1u@loc.gov');
insert into Nutritionists (nutritionist_id, name, contact) values (68, 'Lorry Kunneke', 'lkunneke1v@europa.eu');
insert into Nutritionists (nutritionist_id, name, contact) values (69, 'Chrisy Glide', 'cglide1w@miibeian.gov.cn');
insert into Nutritionists (nutritionist_id, name, contact) values (70, 'Chan Gipps', 'cgipps1x@jiathis.com');
insert into Nutritionists (nutritionist_id, name, contact) values (71, 'Lindsey Scutchin', 'lscutchin1y@theguardian.com');
insert into Nutritionists (nutritionist_id, name, contact) values (72, 'Ricky Ravenscroft', 'rravenscroft1z@mysql.com');
insert into Nutritionists (nutritionist_id, name, contact) values (73, 'Lynsey Hadgkiss', 'lhadgkiss20@hatena.ne.jp');
insert into Nutritionists (nutritionist_id, name, contact) values (74, 'Gayle Adanet', 'gadanet21@t.co');
insert into Nutritionists (nutritionist_id, name, contact) values (75, 'Alisander Filippucci', 'afilippucci22@blog.com');
insert into Nutritionists (nutritionist_id, name, contact) values (76, 'Kip Godson', 'kgodson23@amazon.co.uk');
insert into Nutritionists (nutritionist_id, name, contact) values (77, 'Fredek Dillicate', 'fdillicate24@bing.com');
insert into Nutritionists (nutritionist_id, name, contact) values (78, 'Maxwell Haddow', 'mhaddow25@usda.gov');
insert into Nutritionists (nutritionist_id, name, contact) values (79, 'Gretal Couper', 'gcouper26@xing.com');
insert into Nutritionists (nutritionist_id, name, contact) values (80, 'Raynard Fominov', 'rfominov27@gmpg.org');
insert into Nutritionists (nutritionist_id, name, contact) values (81, 'Ninette Larham', 'nlarham28@rediff.com');
insert into Nutritionists (nutritionist_id, name, contact) values (82, 'Leandra Gaynor', 'lgaynor29@amazonaws.com');
insert into Nutritionists (nutritionist_id, name, contact) values (83, 'Zeke MacGauhy', 'zmacgauhy2a@seattletimes.com');
insert into Nutritionists (nutritionist_id, name, contact) values (84, 'Alonso McCarron', 'amccarron2b@spotify.com');
insert into Nutritionists (nutritionist_id, name, contact) values (85, 'Tommi Giottini', 'tgiottini2c@spiegel.de');

insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Conant Pitcock', 'Solnechnogorsk', 'Hobbies', 61, '37571', 1);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Teriann Frany', 'Lagoa Seca', 'Sports', 91, '2495.02', 2);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Nancee Pagitt', 'Hukeng', 'Reading', 50, '8588.51', 3);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Noelle Gurery', 'Zongjia', 'Sports', 25, '43618.69', 4);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Charo Surgen', 'Łomazy', 'Reading', 21, '40466.65', 5);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Gwenni Debell', 'Krikil', 'Hobbies', 76, '36925.13', 6);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Barnett Faloon', 'Qukou', 'Fashion', 24, '44586.89', 7);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Maribel Doghartie', 'Cerava', 'Poetry', 68, '5782.60', 8);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Jarrod Caulcott', 'Wamba', 'Reading', 25, '49783.10', 9);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Welbie Fenton', 'Pniewy', 'Health', 20, '35117.55', 10);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Joni Dresser', 'Yangshuo', 'Reading', 34, '47100.30', 11);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Rudie Fone', 'Tiebiancheng', 'Poetry', 90, '44589.56', 12);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Sauncho Borrill', 'La Garde', 'Hobbies', 100, '38214.80', 13);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Rog Youdell', 'Tripoli', 'Fashion', 24, '488.11', 14);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Deeanne Steventon', 'Saba Yoi', 'Hobbies', 70, '49593.58', 15);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Mendel Capewell', 'Madruga', 'Poetry', 55, '18381.09', 16);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Baudoin Sucre', 'Huilong', 'Sports', 100, '44588.93', 17);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Tailor Oakley', 'Khoa', 'Poetry', 39, '4077.34', 18);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Constantine Slessor', 'Tacoma', 'Health', 25, '39325.30', 19);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Katy Germon', 'Dłutów', 'Reading', 22, '29062.21', 20);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Seth Woodruffe', 'Nice', 'Art', 44, '32407.98', 21);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Sheelah Hobden', 'Kyriáki', 'Health', 41, '120.49', 22);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Jannelle Brambley', 'Örebro', 'Reading', 80, '24915.01', 23);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Bellina Ren', 'Fiais da Beira', 'Sports', 65, '5070.29', 24);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Clifford Ridde', 'Virovitica', 'Health', 26, '12846.68', 25);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Colan Manby', 'San Carlos de Bariloche', 'Fashion', 70, '45953.82', 26);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Herta Thewlis', 'Las Matas de Farfán', 'Health', 100, '39936.89', 27);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Jacquelyn Paroni', 'Gunajaya', 'Poetry', 70, '32840.01', 28);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Wainwright Pyle', 'Kambatatamakawu', 'Hobbies', 38, '12801.74', 29);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Kirstyn Polak', 'Awayan', 'Sports', 28, '15709.56', 30);
insert into Audiences (name, location, interest, age_range, budget, audience_id) values ('Lazaro Lumsdall', 'Kimanuit', 'Memes', 49, '29789.63', 31);

insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Ignacio Nottingam', 'inottingam0@dailymail.co.uk', '834-540-1652', '6759495396835381863', 1);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Ketty Cavolini', 'kcavolini1@springer.com', '261-569-3136', '3580838821234445', 2);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Jeanie Storey', 'jstorey2@hubpages.com', '814-886-9374', '3554216048990028', 3);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Grata Beernaert', 'gbeernaert3@wsj.com', '899-216-6384', '3528758466870078', 4);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Esma Wippermann', 'ewippermann4@phoca.cz', '622-255-3601', '6304435718270351846', 5);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Shae Coppins', 'scoppins5@woothemes.com', '710-280-8811', '3580752884221027', 6);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Lynnet Pilch', 'lpilch6@nasa.gov', '387-151-0727', '3589137878693368', 7);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Sol Attenbarrow', 'sattenbarrow7@linkedin.com', '588-773-4004', '3584184842213803', 8);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Hetty D''eye', 'hdeye8@livejournal.com', '167-246-2693', '6762548633325785', 9);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Dietrich Gatherer', 'dgatherer9@amazon.co.uk', '509-375-9407', '374288778967322', 10);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Millisent Ummfrey', 'mummfreya@wiley.com', '270-211-2241', '3537460834442644', 11);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Fred Bleakley', 'fbleakleyb@thetimes.co.uk', '217-593-3687', '3556740813577759', 12);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Chrissy Baford', 'cbafordc@hibu.com', '642-112-8199', '3582791798869628', 13);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Keslie Keatley', 'kkeatleyd@about.com', '496-286-6720', '3582545917116547', 14);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Kylie Bruneton', 'kbrunetone@oaic.gov.au', '929-516-4563', '370259092807753', 15);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Marietta Ottewill', 'mottewillf@sakura.ne.jp', '714-178-6363', '6759856129731654', 16);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Morse Ragg', 'mraggg@va.gov', '470-284-7451', '3566303128336730', 17);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Matthias Wedmore.', 'mwedmoreh@cargocollective.com', '513-631-9040', '3562715226719117', 18);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Nonnah Thys', 'nthysi@economist.com', '979-876-3649', '5266417213450145', 19);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Stern Benoit', 'sbenoitj@webeden.co.uk', '889-372-7870', '3578406665817370', 20);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Charlie Backshaw', 'cbackshawk@ebay.co.uk', '337-676-2377', '5100141883397838', 21);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Malanie Cossem', 'mcosseml@sohu.com', '649-998-9847', '3569242444141258', 22);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Jessie Swatradge', 'jswatradgem@xrea.com', '146-922-1839', '4041376740003717', 23);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Libbie Deware', 'ldewaren@topsy.com', '386-728-1450', '3535428241779736', 24);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Torin Sterley', 'tsterleyo@hp.com', '754-901-7860', '3548842577749409', 25);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Merrill Betje', 'mbetjep@phoca.cz', '912-445-4508', '3553157576456019', 26);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Rosita Bertome', 'rbertomeq@google.it', '611-868-3268', '6762252575595162', 27);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Orly Praten', 'opratenr@businessweek.com', '507-649-3133', '374288169136065', 28);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Evey Espadero', 'eespaderos@npr.org', '851-376-1470', '3570843181690667', 29);
insert into Advertisers (name, email, phone, payment_info, advertiser_id) values ('Nikaniki Donnan', 'ndonnant@nhs.uk', '573-733-1992', '5462968545198432', 30);

insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/136x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Helli Christley', '8779.93', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 1, 1);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/111x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Mada Leman', '1251.49', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 2, 2);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/226x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Zitella Castagna', '774.51', 'Fusce consequat. Nulla nisl. Nunc nisl.', 3, 3);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/172x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Theodoric Silber', '4265.46', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 4, 4);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/154x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Angelita Shird', '3740.67', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.', 5, 5);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/235x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Farra Peddie', '7551.67', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 6, 6);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/172x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Hally Queste', '3959.60', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.', 7, 7);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/215x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Kip Gethouse', '8760.03', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 8, 8);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/198x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Morley McLice', '6840.20', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 9, 9);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/149x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Gracie Pidduck', '4397.02', 'Fusce consequat. Nulla nisl. Nunc nisl.', 10, 10);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/157x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Galina Saunton', '4466.67', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 11, 11);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/181x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Hodge Loweth', '1969.74', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 12, 12);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/149x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Pris Nutton', '7734.32', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 13, 13);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/228x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Trevar Goublier', '4495.97', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 14, 14);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/241x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Vance Agneau', '7725.09', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 15, 15);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/204x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Myca Janc', '1467.52', 'In congue. Etiam justo. Etiam pretium iaculis justo.', 16, 16);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/162x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Lindsey Martinat', '7110.82', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.', 17, 17);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/237x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Edie Chadbourne', '3083.85', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 18, 18);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/118x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Angelle Hughman', '3115.13', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 19, 19);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/128x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Letitia Lanahan', '1943.96', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 20, 20);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/183x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Colby Dodamead', '6396.77', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 21, 21);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/201x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Ailsun Abercrombie', '1541.54', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 22, 22);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/122x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Edgar Mashal', '544.38', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 23, 23);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/119x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Aloysius O''Nions', '8380.95', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 24, 24);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/241x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Amitie Trevillion', '1090.34', 'Fusce consequat. Nulla nisl. Nunc nisl.', 25, 25);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/199x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Babbette Cominoli', '8629.49', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 26, 26);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/210x100.png/dddddd/000000', '2023/01/01', '2023/02/02', 'Johan Pullinger', '4183.01', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 27, 27);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/112x100.png/5fa2dd/ffffff', '2023/01/01', '2023/02/02', 'Sibylle Crowne', '9863.15', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 28, 28);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/226x100.png/cc0000/ffffff', '2023/01/01', '2023/02/02', 'Tabby Krikorian', '2670.73', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 29, 29);
insert into Ads (image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id) values ('http://dummyimage.com/228x100.png/ff4444/ffffff', '2023/01/01', '2023/02/02', 'Kari Orrill', '3622.51', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 30, 30);

insert into Engagement (engagement_id, feedback, count, ad_id) values (1, 10, 21384, 1);
insert into Engagement (engagement_id, feedback, count, ad_id) values (2, 8, 36679, 2);
insert into Engagement (engagement_id, feedback, count, ad_id) values (3, 3, 21170, 3);
insert into Engagement (engagement_id, feedback, count, ad_id) values (4, 10, 18334, 4);
insert into Engagement (engagement_id, feedback, count, ad_id) values (5, 3, 41643, 5);
insert into Engagement (engagement_id, feedback, count, ad_id) values (6, 5, 7402, 6);
insert into Engagement (engagement_id, feedback, count, ad_id) values (7, 7, 24992, 7);
insert into Engagement (engagement_id, feedback, count, ad_id) values (8, 9, 3628, 8);
insert into Engagement (engagement_id, feedback, count, ad_id) values (9, 4, 15842, 9);
insert into Engagement (engagement_id, feedback, count, ad_id) values (10, 9, 32636, 10);
insert into Engagement (engagement_id, feedback, count, ad_id) values (11, 9, 49309, 11);
insert into Engagement (engagement_id, feedback, count, ad_id) values (12, 1, 6254, 12);
insert into Engagement (engagement_id, feedback, count, ad_id) values (13, 10, 25790, 13);
insert into Engagement (engagement_id, feedback, count, ad_id) values (14, 2, 42756, 14);
insert into Engagement (engagement_id, feedback, count, ad_id) values (15, 2, 27973, 15);
insert into Engagement (engagement_id, feedback, count, ad_id) values (16, 3, 13502, 16);
insert into Engagement (engagement_id, feedback, count, ad_id) values (17, 10, 27463, 17);
insert into Engagement (engagement_id, feedback, count, ad_id) values (18, 4, 15207, 18);
insert into Engagement (engagement_id, feedback, count, ad_id) values (19, 1, 38470, 19);
insert into Engagement (engagement_id, feedback, count, ad_id) values (20, 6, 291, 20);
insert into Engagement (engagement_id, feedback, count, ad_id) values (21, 5, 6564, 21);
insert into Engagement (engagement_id, feedback, count, ad_id) values (22, 8, 47035, 22);
insert into Engagement (engagement_id, feedback, count, ad_id) values (23, 7, 37578, 23);
insert into Engagement (engagement_id, feedback, count, ad_id) values (24, 6, 10352, 24);
insert into Engagement (engagement_id, feedback, count, ad_id) values (25, 9, 18782, 25);
insert into Engagement (engagement_id, feedback, count, ad_id) values (26, 9, 11155, 26);
insert into Engagement (engagement_id, feedback, count, ad_id) values (27, 2, 35669, 27);
insert into Engagement (engagement_id, feedback, count, ad_id) values (28, 5, 15139, 28);
insert into Engagement (engagement_id, feedback, count, ad_id) values (29, 5, 29712, 29);
insert into Engagement (engagement_id, feedback, count, ad_id) values (30, 9, 20158, 30);

insert into Market_Research (findings, trends, competition, advertiser_id) values (1, 'condimentum id luctus nec molestie sed justo pellentesque viverra pede ac', 'Twitterwire', 1);
insert into Market_Research (findings, trends, competition, advertiser_id) values (2, 'aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam', 'Viva', 2);
insert into Market_Research (findings, trends, competition, advertiser_id) values (3, 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 'Centizu', 3);
insert into Market_Research (findings, trends, competition, advertiser_id) values (4, 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan', 'Jabbertype', 4);
insert into Market_Research (findings, trends, competition, advertiser_id) values (5, 'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus', 'Wikibox', 5);
insert into Market_Research (findings, trends, competition, advertiser_id) values (6, 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt', 'Mynte', 6);
insert into Market_Research (findings, trends, competition, advertiser_id) values (7, 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla', 'Browsetype', 7);
insert into Market_Research (findings, trends, competition, advertiser_id) values (8, 'in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum', 'Kanoodle', 8);
insert into Market_Research (findings, trends, competition, advertiser_id) values (9, 'turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget', 'Twinder', 9);
insert into Market_Research (findings, trends, competition, advertiser_id) values (10, 'in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius', 'Skidoo', 10);
insert into Market_Research (findings, trends, competition, advertiser_id) values (11, 'turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci', 'Katz', 11);
insert into Market_Research (findings, trends, competition, advertiser_id) values (12, 'vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra', 'Edgetag', 12);
insert into Market_Research (findings, trends, competition, advertiser_id) values (13, 'felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla', 'Youfeed', 13);
insert into Market_Research (findings, trends, competition, advertiser_id) values (14, 'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti', 'Zoombox', 14);
insert into Market_Research (findings, trends, competition, advertiser_id) values (15, 'purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac', 'Demimbu', 15);
insert into Market_Research (findings, trends, competition, advertiser_id) values (16, 'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed', 'Jabberbean', 16);
insert into Market_Research (findings, trends, competition, advertiser_id) values (17, 'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel', 'Buzzbean', 17);
insert into Market_Research (findings, trends, competition, advertiser_id) values (18, 'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', 'Demizz', 18);
insert into Market_Research (findings, trends, competition, advertiser_id) values (19, 'faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet', 'Linkbuzz', 19);
insert into Market_Research (findings, trends, competition, advertiser_id) values (20, 'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui', 'Livepath', 20);
insert into Market_Research (findings, trends, competition, advertiser_id) values (21, 'vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a', 'Wikivu', 21);
insert into Market_Research (findings, trends, competition, advertiser_id) values (22, 'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', 'Vitz', 22);
insert into Market_Research (findings, trends, competition, advertiser_id) values (23, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', 'Minyx', 23);
insert into Market_Research (findings, trends, competition, advertiser_id) values (24, 'est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl', 'Gabspot', 24);
insert into Market_Research (findings, trends, competition, advertiser_id) values (25, 'quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', 'Gabspot', 25);
insert into Market_Research (findings, trends, competition, advertiser_id) values (26, 'aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero', 'Quaxo', 26);
insert into Market_Research (findings, trends, competition, advertiser_id) values (27, 'velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis', 'Izio', 27);
insert into Market_Research (findings, trends, competition, advertiser_id) values (28, 'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa', 'Thoughtsphere', 28);
insert into Market_Research (findings, trends, competition, advertiser_id) values (29, 'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum', 'Youspan', 29);
insert into Market_Research (findings, trends, competition, advertiser_id) values (30, 'nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', 'Riffpath', 30);

insert into User_Client (user_id, client_id) values (1, 1);
insert into User_Client (user_id, client_id) values (2, 2);
insert into User_Client (user_id, client_id) values (3, 3);
insert into User_Client (user_id, client_id) values (4, 4);
insert into User_Client (user_id, client_id) values (5, 5);
insert into User_Client (user_id, client_id) values (6, 6);
insert into User_Client (user_id, client_id) values (7, 7);
insert into User_Client (user_id, client_id) values (8, 8);
insert into User_Client (user_id, client_id) values (9, 9);
insert into User_Client (user_id, client_id) values (10, 10);
insert into User_Client (user_id, client_id) values (11, 11);
insert into User_Client (user_id, client_id) values (12, 12);
insert into User_Client (user_id, client_id) values (13, 13);
insert into User_Client (user_id, client_id) values (14, 14);
insert into User_Client (user_id, client_id) values (15, 15);
insert into User_Client (user_id, client_id) values (16, 16);
insert into User_Client (user_id, client_id) values (17, 17);
insert into User_Client (user_id, client_id) values (18, 18);
insert into User_Client (user_id, client_id) values (19, 19);
insert into User_Client (user_id, client_id) values (20, 20);
insert into User_Client (user_id, client_id) values (21, 21);
insert into User_Client (user_id, client_id) values (22, 22);
insert into User_Client (user_id, client_id) values (23, 23);
insert into User_Client (user_id, client_id) values (24, 24);
insert into User_Client (user_id, client_id) values (25, 25);
insert into User_Client (user_id, client_id) values (26, 26);
insert into User_Client (user_id, client_id) values (27, 27);
insert into User_Client (user_id, client_id) values (28, 28);
insert into User_Client (user_id, client_id) values (29, 29);
insert into User_Client (user_id, client_id) values (30, 30);
insert into User_Client (user_id, client_id) values (31, 31);
insert into User_Client (user_id, client_id) values (32, 32);
insert into User_Client (user_id, client_id) values (33, 33);
insert into User_Client (user_id, client_id) values (34, 34);
insert into User_Client (user_id, client_id) values (35, 35);

insert into User_Nutritionist (user_id, nutritionist_id) values (1, 1);
insert into User_Nutritionist (user_id, nutritionist_id) values (2, 2);
insert into User_Nutritionist (user_id, nutritionist_id) values (3, 3);
insert into User_Nutritionist (user_id, nutritionist_id) values (4, 4);
insert into User_Nutritionist (user_id, nutritionist_id) values (5, 5);
insert into User_Nutritionist (user_id, nutritionist_id) values (6, 6);
insert into User_Nutritionist (user_id, nutritionist_id) values (7, 7);
insert into User_Nutritionist (user_id, nutritionist_id) values (8, 8);
insert into User_Nutritionist (user_id, nutritionist_id) values (9, 9);
insert into User_Nutritionist (user_id, nutritionist_id) values (10, 10);
insert into User_Nutritionist (user_id, nutritionist_id) values (11, 11);
insert into User_Nutritionist (user_id, nutritionist_id) values (12, 12);
insert into User_Nutritionist (user_id, nutritionist_id) values (13, 13);
insert into User_Nutritionist (user_id, nutritionist_id) values (14, 14);
insert into User_Nutritionist (user_id, nutritionist_id) values (15, 15);
insert into User_Nutritionist (user_id, nutritionist_id) values (16, 16);
insert into User_Nutritionist (user_id, nutritionist_id) values (17, 17);
insert into User_Nutritionist (user_id, nutritionist_id) values (18, 18);
insert into User_Nutritionist (user_id, nutritionist_id) values (19, 19);
insert into User_Nutritionist (user_id, nutritionist_id) values (20, 20);
insert into User_Nutritionist (user_id, nutritionist_id) values (21, 21);
insert into User_Nutritionist (user_id, nutritionist_id) values (22, 22);
insert into User_Nutritionist (user_id, nutritionist_id) values (23, 23);
insert into User_Nutritionist (user_id, nutritionist_id) values (24, 24);
insert into User_Nutritionist (user_id, nutritionist_id) values (25, 25);
insert into User_Nutritionist (user_id, nutritionist_id) values (26, 26);
insert into User_Nutritionist (user_id, nutritionist_id) values (27, 27);
insert into User_Nutritionist (user_id, nutritionist_id) values (28, 28);
insert into User_Nutritionist (user_id, nutritionist_id) values (29, 29);
insert into User_Nutritionist (user_id, nutritionist_id) values (30, 30);
insert into User_Nutritionist (user_id, nutritionist_id) values (31, 31);
insert into User_Nutritionist (user_id, nutritionist_id) values (32, 32);
insert into User_Nutritionist (user_id, nutritionist_id) values (33, 33);
insert into User_Nutritionist (user_id, nutritionist_id) values (34, 34);
insert into User_Nutritionist (user_id, nutritionist_id) values (35, 35);

insert into User_Audience (user_id, audience_id) values (1, 1);
insert into User_Audience (user_id, audience_id) values (2, 2);
insert into User_Audience (user_id, audience_id) values (3, 3);
insert into User_Audience (user_id, audience_id) values (4, 4);
insert into User_Audience (user_id, audience_id) values (5, 5);
insert into User_Audience (user_id, audience_id) values (6, 6);
insert into User_Audience (user_id, audience_id) values (7, 7);
insert into User_Audience (user_id, audience_id) values (8, 8);
insert into User_Audience (user_id, audience_id) values (9, 9);
insert into User_Audience (user_id, audience_id) values (10, 10);
insert into User_Audience (user_id, audience_id) values (11, 11);
insert into User_Audience (user_id, audience_id) values (12, 12);
insert into User_Audience (user_id, audience_id) values (13, 13);
insert into User_Audience (user_id, audience_id) values (14, 14);
insert into User_Audience (user_id, audience_id) values (15, 15);
insert into User_Audience (user_id, audience_id) values (16, 16);
insert into User_Audience (user_id, audience_id) values (17, 17);
insert into User_Audience (user_id, audience_id) values (18, 18);
insert into User_Audience (user_id, audience_id) values (19, 19);
insert into User_Audience (user_id, audience_id) values (20, 20);
insert into User_Audience (user_id, audience_id) values (21, 21);
insert into User_Audience (user_id, audience_id) values (22, 22);
insert into User_Audience (user_id, audience_id) values (23, 23);
insert into User_Audience (user_id, audience_id) values (24, 24);
insert into User_Audience (user_id, audience_id) values (25, 25);
insert into User_Audience (user_id, audience_id) values (26, 26);
insert into User_Audience (user_id, audience_id) values (27, 27);
insert into User_Audience (user_id, audience_id) values (28, 28);
insert into User_Audience (user_id, audience_id) values (29, 29);
insert into User_Audience (user_id, audience_id) values (30, 30);

insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (1, 1, 751, 'ice cream', 'Needs Work', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (2, 2, 1191, 'pasta', 'Great', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (3, 3, 315, 'pasta', 'Okay', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (4, 4, 692, 'ice cream', 'Okay', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (5, 5, 874, 'chocolate', 'Okay', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (6, 6, 515, 'carrots', 'Needs Work', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (7, 7, 507, 'chocolate', 'Great', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (8, 8, 958, 'ice cream', 'Great', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (9, 9, 1024, 'apples', 'Okay', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (10, 10, 236, 'chocolate', 'Great', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (11, 11, 1064, 'apples', 'Needs Work', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (12, 12, 872, 'bananas', 'Okay', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (13, 13, 886, 'chocolate', 'Great', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (14, 14, 1043, 'apples', 'Great', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (15, 15, 669, 'pasta', 'Needs Work', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (16, 16, 1164, 'pasta', 'Great', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (17, 17, 951, 'pasta', 'Great', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (18, 18, 977, 'pasta', 'Okay', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (19, 19, 386, 'pasta', 'Great', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (20, 20, 1038, 'pizza', 'Needs Work', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (21, 21, 546, 'pizza', 'Needs Work', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (22, 22, 398, 'apples', 'Great', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (23, 23, 362, 'bananas', 'Needs Work', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (24, 24, 729, 'pasta', 'Needs Work', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (25, 25, 696, 'chocolate', 'Okay', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (26, 26, 895, 'chocolate', 'Great', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (27, 27, 264, 'pasta', 'Great', 'Breakfast', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (28, 28, 1059, 'pasta', 'Okay', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (29, 29, 1182, 'carrots', 'Okay', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (30, 30, 1154, 'pasta', 'Okay', 'Dinner', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (31, 31, 422, 'apples', 'Great', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (32, 32, 216, 'chocolate', 'Great', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (33, 33, 828, 'pizza', 'Needs Work', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (34, 34, 328, 'carrots', 'Okay', 'Lunch', '2023/09/09');
insert into Food_Log (food_log_id, client_id, calories, food_items, comments, meal_type, date) values (35, 35, 826, 'apples', 'Okay', 'Breakfast', '2023/09/09');

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '18:12:00', '10:52', 9, '13:24:00', 'Sunday', 1, 1);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '20:03:00', '20:41', 12, '18:08:00', 'Tuesday', 2, 2);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '11:15:00', '3:57', 1, '07:29:00', 'Saturday', 3, 3);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '12:09:00', '17:11', 23, '17:59:00', 'Monday', 4, 4);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '02:42:00', '4:33', 7, '15:08:00', 'Monday', 5, 5);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '21:56:00', '19:16', 12, '15:02:00', 'Saturday', 6, 6);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '17:51:00', '14:04', 8, '15:57:00', 'Sunday', 7, 7);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '02:44:00', '21:04', 5, '16:58:00', 'Saturday', 8, 8);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '10:42:00', '15:11', 3, '12:17:00', 'Sunday', 9, 9);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '21:27:00', '11:53', 4, '09:18:00', 'Monday', 10, 10);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '11:56:00', '9:32', 11, '19:24:00', 'Friday', 11, 11);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '13:57:00', '8:33', 11, '02:35:00', 'Sunday', 12, 12);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '03:02:00', '13:35', 11, '07:05:00', 'Wednesday', 13, 13);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '00:40:00', '17:54', 17, '12:35:00', 'Monday', 14, 14);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '01:06:00', '22:48', 9, '01:16:00', 'Thursday', 15, 15);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '13:47:00', '17:08', 1, '05:50:00', 'Saturday', 16, 16);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '22:29:00', '10:54', 23, '11:49:00', 'Wednesday', 17, 17);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '05:36:00', '14:57', 14, '23:39:00', 'Monday', 18, 18);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '07:52:00', '13:06', 13, '06:00:00', 'Monday', 19, 19);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '03:44:00', '18:07', 21, '07:15:00', 'Wednesday', 20, 20);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '10:43:00', '11:53', 13, '02:42:00', 'Thursday', 21, 21);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '14:25:00', '12:41', 3, '11:18:00', 'Thursday', 22, 22);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '21:46:00', '16:51', 10, '04:53:00', 'Wednesday', 23, 23);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '01:19:00', '08:39', 16, '06:05:00', 'Monday', 24, 24);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '01:55:00', '08:26', 20, '07:39:00', 'Wednesday', 25, 25);

INSERT INTO Schedule (calendar, time_of_day, food_timeline, hours, exercise_time_line, day_of_week, client_id, schedule_id)
VALUES ('2023-09-09', '09:54:00', '10:10', 15, '21:44:00', 'Friday', 26, 26);

insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (24, 4, 173.39, 13, 1, 197, 1);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (32, 71, 39.49, 19, 2, 187, 2);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (40, 35, 289.71, 15, 3, 161, 3);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (33, 26, 75.75, 20, 4, 186, 4);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (17, 35, 60.06, 12, 5, 168, 5);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (16, 37, 40.94, 17, 6, 177, 6);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (25, 14, 87.76, 14, 7, 179, 7);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (31, 1, 252.64, 13, 8, 151, 8);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (20, 25, 208.66, 19, 9, 160, 9);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (22, 3, 276.22, 17, 10, 174, 10);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (17, 35, 8.83, 13, 11, 178, 11);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (16, 75, 63.77, 13, 12, 152, 12);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (32, 6, 229.53, 18, 13, 139, 13);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (30, 56, 51.53, 18, 14, 167, 14);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (39, 69, 31.82, 20, 15, 183, 15);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (40, 16, 56.21, 17, 16, 177, 16);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (39, 5, 237.23, 15, 17, 173, 17);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (17, 64, 135.83, 16, 18, 183, 18);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (28, 57, 118.61, 14, 19, 138, 19);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (28, 79, 183.97, 18, 20, 151, 20);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (29, 23, 269.69, 15, 21, 178, 21);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (28, 72, 61.23, 14, 22, 136, 22);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (33, 10, 139.01, 15, 23, 163, 23);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (26, 32, 299.24, 18, 24, 174, 24);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (34, 7, 147.06, 13, 25, 156, 25);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (30, 64, 39.53, 13, 26, 157, 26);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (36, 33, 237.91, 16, 27, 177, 27);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (25, 70, 184.91, 12, 28, 137, 28);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (22, 27, 105.3, 13, 29, 174, 29);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (18, 41, 90.71, 17, 30, 140, 30);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (16, 78, 163.2, 14, 31, 183, 31);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (22, 57, 74.24, 13, 32, 196, 32);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (38, 58, 292.5, 18, 33, 185, 33);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (40, 23, 166.22, 18, 34, 190, 34);
insert into Exercise_Info (BMI, height, weight, breaths_per_minute, user_id, max_HR, exercise_id) values (24, 9, 15.68, 15, 35, 166, 35);

insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (1, 1, '2024/01/01', 'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem', 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper', '2024/01/01', 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (2, 2, '2024/01/01', 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui', 'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam', '2024/01/01', 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (3, 3, '2024/01/01', 'condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum', 'risus semper porta volutpat quam pede lobortis ligula sit amet', '2024/01/01', 'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (4, 4, '2024/01/01', 'in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 'vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti', '2024/01/01', 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (5, 5, '2024/01/01', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 'vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel', '2024/01/01', 'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (6, 6, '2024/01/01', 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis', 'ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus', '2024/01/01', 'ligula suspendisse ornare consequat lectus in est risus auctor sed');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (7, 7, '2024/01/01', 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id', 'dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse', '2024/01/01', 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (8, 8, '2024/01/01', 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque', 'nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh', '2024/01/01', 'pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (9, 9, '2024/01/01', 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec', 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum', '2024/01/01', 'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (10, 10, '2024/01/01', 'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem', 'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis', '2024/01/01', 'dui vel sem sed sagittis nam congue risus semper porta');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (11, 11, '2024/01/01', 'lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus', 'luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo', '2024/01/01', 'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (12, 12, '2024/01/01', 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non', 'nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', '2024/01/01', 'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (13, 13, '2024/01/01', 'mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse', 'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio', '2024/01/01', 'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (14, 14, '2024/01/01', 'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum', 'amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui', '2024/01/01', 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (15, 15, '2024/01/01', 'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo', 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis', '2024/01/01', 'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (16, 16, '2024/01/01', 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc', 'in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere', '2024/01/01', 'iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (17, 17, '2024/01/01', 'ante ipsum primis in faucibus orci luctus et ultrices posuere', 'in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', '2024/01/01', 'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (18, 18, '2024/01/01', 'donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis', 'mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel', '2024/01/01', 'quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (19, 19, '2024/01/01', 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh', 'id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et', '2024/01/01', 'justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (20, 20, '2024/01/01', 'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', 'amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', '2024/01/01', 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (21, 21, '2024/01/01', 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur', 'vel enim sit amet nunc viverra dapibus nulla suscipit ligula', '2024/01/01', 'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (22, 22, '2024/01/01', 'nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem', 'non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', '2024/01/01', 'sapien quis libero nullam sit amet turpis elementum ligula vehicula');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (23, 23, '2024/01/01', 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet', 'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum', '2024/01/01', 'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (24, 24, '2024/01/01', 'habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum', 'proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu', '2024/01/01', 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (25, 25, '2024/01/01', 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu', 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit', '2024/01/01', 'tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (26, 26, '2024/01/01', 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', 'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean', '2024/01/01', 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (27, 27, '2024/01/01', 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis', 'augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec', '2024/01/01', 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (28, 28, '2024/01/01', 'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec', '2024/01/01', 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (29, 29, '2024/01/01', 'egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', 'platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia', '2024/01/01', 'et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (30, 30, '2024/01/01', 'posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus', 'praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', '2024/01/01', 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros');
insert into Report (report_id, client_id, date, text, recommendation, report_date, progress_summary) values (31, 31, '2024/01/01', 'ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit', 'blandit mi in porttitor pede justo eu massa donec dapibus duis', '2024/01/01', 'ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida');

insert into Communication (communication_id, client_id, date, message) values (1, 1, '2024/01/01', 'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh');
insert into Communication (communication_id, client_id, date, message) values (2, 2, '2024/01/01', 'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio');
insert into Communication (communication_id, client_id, date, message) values (3, 3, '2024/01/01', 'congue elementum in hac habitasse platea dictumst morbi vestibulum velit');
insert into Communication (communication_id, client_id, date, message) values (4, 4, '2024/01/01', 'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio');
insert into Communication (communication_id, client_id, date, message) values (5, 5, '2024/01/01', 'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti');
insert into Communication (communication_id, client_id, date, message) values (6, 6, '2024/01/01', 'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy');
insert into Communication (communication_id, client_id, date, message) values (7, 7, '2024/01/01', 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque');
insert into Communication (communication_id, client_id, date, message) values (8, 8, '2024/01/01', 'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis');
insert into Communication (communication_id, client_id, date, message) values (9, 9, '2024/01/01', 'diam erat fermentum justo nec condimentum neque sapien placerat ante');
insert into Communication (communication_id, client_id, date, message) values (10, 10, '2024/01/01', 'donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac');
insert into Communication (communication_id, client_id, date, message) values (11, 11, '2024/01/01', 'phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum');
insert into Communication (communication_id, client_id, date, message) values (12, 12, '2024/01/01', 'duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa');
insert into Communication (communication_id, client_id, date, message) values (13, 13, '2024/01/01', 'enim blandit mi in porttitor pede justo eu massa donec');
insert into Communication (communication_id, client_id, date, message) values (14, 14, '2024/01/01', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus');
insert into Communication (communication_id, client_id, date, message) values (15, 15, '2024/01/01', 'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat');
insert into Communication (communication_id, client_id, date, message) values (16, 16, '2024/01/01', 'enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac');
insert into Communication (communication_id, client_id, date, message) values (17, 17, '2024/01/01', 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna');
insert into Communication (communication_id, client_id, date, message) values (18, 18, '2024/01/01', 'metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh');
insert into Communication (communication_id, client_id, date, message) values (19, 19, '2024/01/01', 'vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi');
insert into Communication (communication_id, client_id, date, message) values (20, 20, '2024/01/01', 'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis');
insert into Communication (communication_id, client_id, date, message) values (21, 21, '2024/01/01', 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus');
insert into Communication (communication_id, client_id, date, message) values (22, 22, '2024/01/01', 'diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna');
insert into Communication (communication_id, client_id, date, message) values (23, 23, '2024/01/01', 'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus');
insert into Communication (communication_id, client_id, date, message) values (24, 24, '2024/01/01', 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus');
insert into Communication (communication_id, client_id, date, message) values (25, 25, '2024/01/01', 'orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu');
insert into Communication (communication_id, client_id, date, message) values (26, 26, '2024/01/01', 'ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus');
insert into Communication (communication_id, client_id, date, message) values (27, 27, '2024/01/01', 'molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus');
insert into Communication (communication_id, client_id, date, message) values (28, 28, '2024/01/01', 'proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum');
insert into Communication (communication_id, client_id, date, message) values (29, 29, '2024/01/01', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi');
insert into Communication (communication_id, client_id, date, message) values (30, 30, '2024/01/01', 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere');

insert into Audience_Engagement (audience_id, engagement_id) values (1, 1);
insert into Audience_Engagement (audience_id, engagement_id) values (2, 2);
insert into Audience_Engagement (audience_id, engagement_id) values (3, 3);
insert into Audience_Engagement (audience_id, engagement_id) values (4, 4);
insert into Audience_Engagement (audience_id, engagement_id) values (5, 5);
insert into Audience_Engagement (audience_id, engagement_id) values (6, 6);
insert into Audience_Engagement (audience_id, engagement_id) values (7, 7);
insert into Audience_Engagement (audience_id, engagement_id) values (8, 8);
insert into Audience_Engagement (audience_id, engagement_id) values (9, 9);
insert into Audience_Engagement (audience_id, engagement_id) values (10, 10);
insert into Audience_Engagement (audience_id, engagement_id) values (11, 11);
insert into Audience_Engagement (audience_id, engagement_id) values (12, 12);
insert into Audience_Engagement (audience_id, engagement_id) values (13, 13);
insert into Audience_Engagement (audience_id, engagement_id) values (14, 14);
insert into Audience_Engagement (audience_id, engagement_id) values (15, 15);
insert into Audience_Engagement (audience_id, engagement_id) values (16, 16);
insert into Audience_Engagement (audience_id, engagement_id) values (17, 17);
insert into Audience_Engagement (audience_id, engagement_id) values (18, 18);
insert into Audience_Engagement (audience_id, engagement_id) values (19, 19);
insert into Audience_Engagement (audience_id, engagement_id) values (20, 20);
insert into Audience_Engagement (audience_id, engagement_id) values (21, 21);
insert into Audience_Engagement (audience_id, engagement_id) values (22, 22);
insert into Audience_Engagement (audience_id, engagement_id) values (23, 23);
insert into Audience_Engagement (audience_id, engagement_id) values (24, 24);
insert into Audience_Engagement (audience_id, engagement_id) values (25, 25);
insert into Audience_Engagement (audience_id, engagement_id) values (26, 26);
insert into Audience_Engagement (audience_id, engagement_id) values (27, 27);
insert into Audience_Engagement (audience_id, engagement_id) values (28, 28);
insert into Audience_Engagement (audience_id, engagement_id) values (29, 29);
insert into Audience_Engagement (audience_id, engagement_id) values (30, 30);

insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (1, '2024/01/01', 'pasta', 'dinner', 1, 'and certain vitamins and minerals', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (2, '2024/01/01', 'carrots', 'lunch', 2, 'trans fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (3, '2024/01/01', 'chocolate', 'snack', 3, 'total sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (4, '2024/01/01', 'ice cream', 'breakfast', 4, 'dietary fiber', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (5, '2024/01/01', 'apples', 'snack', 5, 'saturated fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (6, '2024/01/01', 'pizza', 'snack', 6, 'dietary fiber', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (7, '2024/01/01', 'bananas', 'lunch', 7, 'sodium', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (8, '2024/01/01', 'pizza', 'breakfast', 8, 'added sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (9, '2024/01/01', 'pasta', 'dinner', 9, 'trans fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (10, '2024/01/01', 'carrots', 'dinner', 10, 'cholesterol', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (11, '2024/01/01', 'carrots', 'snack', 11, 'total carbohydrate', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (12, '2024/01/01', 'pizza', 'lunch', 12, 'added sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (13, '2024/01/01', 'apples', 'breakfast', 13, 'fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (14, '2024/01/01', 'apples', 'breakfast', 14, 'added sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (15, '2024/01/01', 'chocolate', 'lunch', 15, 'and certain vitamins and minerals', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (16, '2024/01/01', 'apples', 'breakfast', 16, 'protein', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (17, '2024/01/01', 'ice cream', 'dinner', 17, 'saturated fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (18, '2024/01/01', 'carrots', 'lunch', 18, 'protein', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (19, '2024/01/01', 'bananas', 'dinner', 19, 'saturated fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (20, '2024/01/01', 'chocolate', 'dinner', 20, 'trans fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (21, '2024/01/01', 'carrots', 'breakfast', 21, 'added sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (22, '2024/01/01', 'bananas', 'lunch', 22, 'fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (23, '2024/01/01', 'pasta', 'dinner', 23, 'total carbohydrate', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (24, '2024/01/01', 'ice cream', 'dinner', 24, 'total sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (25, '2024/01/01', 'apples', 'dinner', 25, 'trans fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (26, '2024/01/01', 'pizza', 'dinner', 26, 'total carbohydrate', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (27, '2024/01/01', 'pasta', 'lunch', 27, 'added sugars', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (28, '2024/01/01', 'apples', 'snack', 28, 'saturated fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (29, '2024/01/01', 'apples', 'lunch', 29, 'fat', '2024/01/01');
insert into Meal_Plan (client_id, created_at, ingredients, description, meal_plan_id, nutrition_info, updated_date) values (30, '2024/01/01', 'apples', 'breakfast', 30, 'dietary fiber', '2024/01/01');

insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (816, 1, 'copper', 'vitamin B');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (849, 2, 'magnesium', 'vitamin A');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (861, 3, 'pphosphorus', 'vitamin B');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (469, 4, 'zinc', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (945, 5, 'calcium', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (845, 6, 'magnesium', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (858, 7, 'potassium', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (369, 8, 'magnesium', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (687, 9, 'zinc', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (71, 10, 'zinc', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (973, 11, 'chloride', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (780, 12, 'copper', 'vitamin C');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (771, 13, 'copper', 'vitamin A');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (475, 14, 'zinc', 'vitamin A');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (315, 15, 'chromium', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (410, 16, 'calcium', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (46, 17, 'copper', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (824, 18, 'fluoride', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (579, 19, 'fluoride', 'vitamin B');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (8, 20, 'zinc', 'vitamin C');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (560, 21, 'zinc', 'vitamin B');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (486, 22, 'iron', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (885, 23, 'sodium', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (187, 24, 'chromium', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (583, 25, 'chloride', 'vitamin C');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (661, 26, 'sodium', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (904, 27, 'iodine', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (645, 28, 'iron', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (695, 29, 'chromium', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (921, 30, 'iron', 'vitamin A');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (985, 31, 'fluoride', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (9, 32, 'magnesium', 'vitamin E');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (396, 33, 'copper', 'vitamin K');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (835, 34, 'iodine', 'vitamin D');
insert into Vitamins_Minerals (quantity, food_log_id, mineral_type, vitamin_type) values (726, 35, 'iron', 'vitamin K');
