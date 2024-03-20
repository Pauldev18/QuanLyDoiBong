create database quanlydoibong;
use quanlydoibong;

create table Team
(
    idteam int auto_increment primary key,
    team_name nvarchar(255) not null,
    coach_name nvarchar(255) not null,
    country nvarchar(255) not null
);
CREATE TABLE player
(
    idplayer int auto_increment primary key,
    full_name nvarchar(255) not null,
    date_of_birth date not null,
    country nvarchar(255) not null,
    position nvarchar(255) not null,
    jersey_number nvarchar(15) not null,
    photo longtext,
    height nvarchar(25),
    weight nvarchar(25),
    email nvarchar(50),
    phone nvarchar(50),
    IDTeam int,
    contract_start_date date,
    contract_end_date date,
    foreign key(idteam) references Team(idteam)
);

create table tournaments
(
    idtournaments int auto_increment primary key,
    tournaments_name nvarchar(255) not null,
    start_date date,
    end_date date
);
create table matches
(
    idmatch  int auto_increment primary key,
    idtournaments int,
    home_teamid int,
    away_teamid int,
    home_team_score int,
    away_team_score int,
    match_date date,
    status nvarchar(25),
    yellow_cards_home_team int,
    red_cards_home_team int,
    yellow_cards_away_team int,
    red_cards_away_team int,
    loai_tran_dau nvarchar(255),
    foreign key(idtournaments) references tournaments(idtournaments),
    foreign key(home_teamid) references Team(idteam),
    foreign key(away_teamid) references Team(idteam)
);
create table Standings
(
    idstandings int auto_increment primary key,
    idteam int,
    idtournaments int,
    points int,
    foreign key(idteam) references Team(idteam),
    foreign key(idtournaments) references tournaments(idtournaments)
);
create table goals
(
    idgoals int auto_increment primary key,
    idmatch int,
    idplayer int,
    goal_time time,
    idteam int,
    foreign key(idteam) references Team(idteam),
    foreign key(idmatch) references matches(idmatch),
    foreign key(idplayer) references player(idplayer)
);
create table cards
(
    idcard int auto_increment primary key,
    idmatch int,
    idplayer int,
    yellow_cards INT,
    red_cards INT,
    idteam int,
    foreign key(idteam) references Team(idteam),
    foreign key(idmatch) references matches(idmatch),
    foreign key(idplayer) references player(idplayer)
);
create table accounts
(
    user_name nvarchar(255) not null primary key,
    pass_word nvarchar(255) not null,
    role nvarchar(255) not null
);

-- trigger tính điểm 
DELIMITER //
CREATE TRIGGER CalculatePointsAfterMatchInsert
    AFTER UPDATE ON matches
    FOR EACH ROW
BEGIN
    DECLARE HomeTeamPoints INT;
    DECLARE AwayTeamPoints INT;
    DECLARE existingHomeTeam INT;
    DECLARE existingAwayTeam INT;

    IF NEW.loai_tran_dau = 'chinhthuc' THEN

        -- Tính điểm cho đội nhà
        SET HomeTeamPoints = CASE
                                WHEN NEW.home_team_score > NEW.away_team_score THEN 3
                                WHEN NEW.home_team_score = NEW.away_team_score THEN 1
                                ELSE 0
END;

-- Tính điểm cho đội khách
SET AwayTeamPoints = CASE
                                WHEN NEW.away_team_score > NEW.home_team_score THEN 3
                                WHEN NEW.home_team_score = NEW.away_team_score THEN 1
                                ELSE 0
END;

        -- Kiểm tra xem trận đấu đã kết thúc chưa
        IF NEW.status = 'Finished' THEN

            -- Tìm kiếm điểm của đội nhà trong bảng Standings
SELECT idteam INTO existingHomeTeam
FROM Standings
WHERE idteam = NEW.home_teamid AND idtournaments = NEW.idtournaments;

-- Tìm kiếm điểm của đội khách trong bảng Standings
SELECT idteam INTO existingAwayTeam
FROM Standings
WHERE idteam = NEW.away_teamid AND idtournaments = NEW.idtournaments;

-- Kiểm tra xem điểm cho đội nhà đã tồn tại trong bảng Standings hay chưa, nếu chưa thì thêm mới, nếu có rồi thì cập nhật
IF existingHomeTeam IS NULL THEN
                INSERT INTO Standings (idteam, idtournaments, points)
                VALUES (NEW.home_teamid, NEW.idtournaments, HomeTeamPoints);
ELSE
UPDATE Standings
SET points = points + HomeTeamPoints
WHERE idteam = NEW.home_teamid AND idtournaments = NEW.idtournaments;
END IF;

            -- Kiểm tra xem điểm cho đội khách đã tồn tại trong bảng Standings hay chưa, nếu chưa thì thêm mới, nếu có rồi thì cập nhật
            IF existingAwayTeam IS NULL THEN
                INSERT INTO Standings (idteam, idtournaments, points)
                VALUES (NEW.away_teamid, NEW.idtournaments, AwayTeamPoints);
ELSE
UPDATE Standings
SET points = points + AwayTeamPoints
WHERE idteam = NEW.away_teamid AND idtournaments = NEW.idtournaments;
END IF;

END IF;
END IF;
END;
//
DELIMITER ;
-- Đội bóng Barcelona
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Barcelona', 'Xavi Hernandez', 'Spain');

-- Đội bóng Real Madrid
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Real Madrid', 'Carlo Ancelotti', 'Spain');

-- Đội bóng Manchester City
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Manchester City', 'Pep Guardiola', 'England');

-- Đội bóng Liverpool
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Liverpool', 'Jürgen Klopp', 'England');

-- Đội bóng Paris Saint-Germain
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Paris Saint-Germain', 'Mauricio Pochettino', 'France');

-- Đội bóng Bayern Munich
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Bayern Munich', 'Julian Nagelsmann', 'Germany');

-- Đội bóng Juventus
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Juventus', 'Massimiliano Allegri', 'Italy');

-- Đội bóng Chelsea
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Chelsea', 'Thomas Tuchel', 'England');

-- Đội bóng Manchester United
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Manchester United', 'Ralf Rangnick', 'England');

-- Đội bóng Arsenal
INSERT INTO Team (team_name, coach_name, country)
VALUES ('Arsenal', 'Mikel Arteta', 'England');


-- Giải đấu World Cup
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('World Cup', '2026-06-12', '2026-07-13');

-- UEFA Champions League
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('UEFA Champions League', '2024-09-17', '2025-05-30');

-- Copa America
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Copa America', '2024-06-13', '2024-07-10');

-- Premier League
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Premier League', '2023-08-12', '2024-05-17');

-- La Liga
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('La Liga', '2023-08-13', '2024-05-19');

-- Serie A
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Serie A', '2023-08-19', '2024-05-26');

-- Bundesliga
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Bundesliga', '2023-08-18', '2024-05-18');

-- Ligue 1
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Ligue 1', '2023-08-04', '2024-05-25');

-- FA Cup
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('FA Cup', '2024-08-01', '2024-05-25');

-- Copa del Rey
INSERT INTO tournaments (tournaments_name, start_date, end_date)
VALUES ('Copa del Rey', '2024-09-07', '2024-05-18');
-- Cầu thủ Cristiano Ronaldo
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Cristiano Ronaldo', '1985-02-05', 'Portugal', 'Forward', '7', '187cm', '83kg', 'ronaldo@example.com', '+351123456789', 1, '2023-07-01', '2025-06-30');

-- Cầu thủ Lionel Messi
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Lionel Messi', '1987-06-24', 'Argentina', 'Forward', '10', '170cm', '72kg', 'messi@example.com', '+541234567890', 1, '2024-01-01', '2026-12-31');

-- Cầu thủ Neymar Jr.
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Neymar Jr.', '1992-02-05', 'Brazil', 'Forward', '10', '175cm', '68kg', 'neymar@example.com', '+551112345678', 2, '2022-08-15', '2024-08-14');

-- Cầu thủ Kylian Mbappé
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Kylian Mbappé', '1998-12-20', 'France', 'Forward', '7', '178cm', '73kg', 'mbappe@example.com', '+33612345678', 1, '2023-06-01', '2025-05-31');

-- Cầu thủ Robert Lewandowski
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Robert Lewandowski', '1988-08-21', 'Poland', 'Forward', '9', '185cm', '79kg', 'lewandowski@example.com', '+48765432109', 3, '2022-07-01', '2024-06-30');

-- Cầu thủ Sergio Ramos
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Sergio Ramos', '1986-03-30', 'Spain', 'Defender', '4', '183cm', '75kg', 'ramos@example.com', '+34678901234', 4, '2023-01-01', '2025-12-31');

-- Cầu thủ Kevin De Bruyne
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Kevin De Bruyne', '1991-06-28', 'Belgium', 'Midfielder', '17', '181cm', '68kg', 'debruyne@example.com', '+32456789012', 3, '2024-02-01', '2026-01-31');

-- Cầu thủ Mohamed Salah
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Mohamed Salah', '1992-06-15', 'Egypt', 'Forward', '11', '175cm', '71kg', 'salah@example.com', '+201234567890', 1, '2022-09-01', '2024-08-31');

-- Cầu thủ Virgil van Dijk
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Virgil van Dijk', '1991-07-08', 'Netherlands', 'Defender', '4', '193cm', '92kg', 'vandijk@example.com', '+31678901234', 2, '2023-03-15', '2025-03-14');

-- Cầu thủ Harry Kane
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Harry Kane', '1993-07-28', 'England', 'Forward', '10', '188cm', '86kg', 'kane@example.com', '+447890123456', 5, '2022-06-01', '2024-05-31');
-- Cầu thủ Manuel Neuer
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Manuel Neuer', '1986-03-27', 'Germany', 'Goalkeeper', '1', '193cm', '92kg', 'neuer@example.com', '+491234567890', 6, '2023-08-01', '2025-07-31');

-- Cầu thủ Eden Hazard
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Eden Hazard', '1991-01-07', 'Belgium', 'Forward', '10', '173cm', '74kg', 'hazard@example.com', '+32456789012', 7, '2023-05-15', '2025-05-14');

-- Cầu thủ Antoine Griezmann
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Antoine Griezmann', '1991-03-21', 'France', 'Forward', '7', '176cm', '73kg', 'griezmann@example.com', '+33678901234', 2, '2022-10-01', '2024-09-30');

-- Cầu thủ Luka Modric
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Luka Modric', '1985-09-09', 'Croatia', 'Midfielder', '10', '172cm', '66kg', 'modric@example.com', '+38512345678', 8, '2023-04-01', '2025-03-31');

-- Cầu thủ Paul Pogba
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Paul Pogba', '1993-03-15', 'France', 'Midfielder', '6', '191cm', '84kg', 'pogba@example.com', '+33612345678', 3, '2022-12-01', '2024-11-30');

-- Cầu thủ Toni Kroos
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Toni Kroos', '1990-01-04', 'Germany', 'Midfielder', '8', '183cm', '76kg', 'kroos@example.com', '+491234567890', 6, '2023-06-01', '2025-05-31');

-- Cầu thủ Alisson Becker
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Alisson Becker', '1992-10-02', 'Brazil', 'Goalkeeper', '1', '191cm', '91kg', 'alisson@example.com', '+551234567890', 4, '2024-01-01', '2026-12-31');

-- Cầu thủ Bruno Fernandes
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Bruno Fernandes', '1994-09-08', 'Portugal', 'Midfielder', '18', '179cm', '69kg', 'fernandes@example.com', '+351123456789', 5, '2023-07-15', '2025-07-14');

-- Cầu thủ Erling Haaland
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Erling Haaland', '2000-07-21', 'Norway', 'Forward', '9', '194cm', '87kg', 'haaland@example.com', '+479876543210', 9, '2023-09-01', '2025-08-31');

-- Cầu thủ Jadon Sancho
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES ('Jadon Sancho', '2000-03-25', 'England', 'Forward', '7', '180cm', '76kg', 'sancho@example.com', '+447890123456', 10, '2022-08-01', '2024-07-31');
