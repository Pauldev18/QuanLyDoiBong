create database quanlydoibong;
use quanlydoibong;

create table Team
(
    IDTeam int auto_increment primary key,
    team_name nvarchar(255) not null,
    coach_name nvarchar(255) not null,
    country nvarchar(255) not null
);
CREATE TABLE player
(
    IDPlayer int auto_increment primary key,
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
    foreign key(IDTeam) references Team(IDTeam)
);

create table tournaments
(
    IDTournaments int auto_increment primary key,
    tournaments_name nvarchar(255) not null,
    start_date date,
    end_date date
);
create table matches
(
    MatchID  int auto_increment primary key,
    IDTournaments int,
    HomeTeamID int,
    AwayTeamID int,
    HomeTeamScore int,
    AwayTeamScore int,
    MatchDate date,
    status nvarchar(25),
    YellowCardsHomeTeam int,
    RedCardsHomeTeam int,
    YellowCardsAwayTeam int,
    RedCardsAwayTeam int,
    LoaiTranDau nvarchar(255),
    foreign key(IDTournaments) references tournaments(IDTournaments),
    foreign key(HomeTeamID) references Team(IDTeam),
    foreign key(AwayTeamID) references Team(IDTeam)
);
create table Standings
(
    IDStandings int auto_increment primary key,
    TeamID int,
    IDTournaments int,
    Points int,
    foreign key(TeamID) references Team(IDTeam),
    foreign key(IDTournaments) references tournaments(IDTournaments)
);
create table goals
(
    IDGoals int auto_increment primary key,
    MatchID int,
    IDPlayer int,
    GoalTime time,
    foreign key(MatchID) references matches(MatchID),
    foreign key(IDPlayer) references player(IDPlayer)
);
create table cards
(
    IDCard int auto_increment primary key,
    MatchID int,
    IDPlayer int,
    YellowCards INT,
    RedCards INT,
    foreign key(MatchID) references matches(MatchID),
    foreign key(IDPlayer) references player(IDPlayer)
);
-- trigger tính điểm
DELIMITER //
CREATE TRIGGER CalculatePointsAfterMatchInsert
    AFTER INSERT ON matches
    FOR EACH ROW
BEGIN
    DECLARE HomeTeamPoints INT;
    DECLARE AwayTeamPoints INT;
    DECLARE existingHomeTeam INT;
    DECLARE existingAwayTeam INT;

    -- Tìm kiếm điểm của đội nhà trong bảng Standings
    SELECT TeamID INTO existingHomeTeam
    FROM Standings
    WHERE TeamID = NEW.HomeTeamID AND IDTournaments = NEW.IDTournaments;

    -- Tìm kiếm điểm của đội khách trong bảng Standings
    SELECT TeamID INTO existingAwayTeam
    FROM Standings
    WHERE TeamID = NEW.AwayTeamID AND IDTournaments = NEW.IDTournaments;

    -- Tính điểm cho đội nhà
    IF NEW.HomeTeamScore > NEW.AwayTeamScore THEN
        SET HomeTeamPoints = 3;
    ELSEIF NEW.HomeTeamScore = NEW.AwayTeamScore THEN
        SET HomeTeamPoints = 1;
    ELSE
        SET HomeTeamPoints = 0;
END IF;

-- Tính điểm cho đội khách
IF NEW.AwayTeamScore > NEW.HomeTeamScore THEN
        SET AwayTeamPoints = 3;
    ELSEIF NEW.HomeTeamScore = NEW.AwayTeamScore THEN
        SET AwayTeamPoints = 1;
ELSE
        SET AwayTeamPoints = 0;
END IF;

    -- Kiểm tra xem điểm cho đội nhà đã tồn tại trong bảng Standings hay chưa, nếu chưa thì thêm mới, nếu có rồi thì cập nhật
    IF existingHomeTeam IS NULL THEN
        INSERT INTO Standings (TeamID, IDTournaments, Points)
        VALUES (NEW.HomeTeamID, NEW.IDTournaments, HomeTeamPoints);
ELSE
UPDATE Standings
SET Points = Points + HomeTeamPoints
WHERE TeamID = NEW.HomeTeamID AND IDTournaments = NEW.IDTournaments;
END IF;

    -- Kiểm tra xem điểm cho đội khách đã tồn tại trong bảng Standings hay chưa, nếu chưa thì thêm mới, nếu có rồi thì cập nhật
    IF existingAwayTeam IS NULL THEN
        INSERT INTO Standings (TeamID, IDTournaments, Points)
        VALUES (NEW.AwayTeamID, NEW.IDTournaments, AwayTeamPoints);
ELSE
UPDATE Standings
SET Points = Points + AwayTeamPoints
WHERE TeamID = NEW.AwayTeamID AND IDTournaments = NEW.IDTournaments;
END IF;
END;
//

DELIMITER ;

-- Thêm 5 bản ghi vào bảng Team
INSERT INTO Team (team_name, coach_name, country) VALUES
                                                      ('Team A', 'Coach A', 'Country A'),
                                                      ('Team B', 'Coach B', 'Country B'),
                                                      ('Team C', 'Coach C', 'Country C'),
                                                      ('Team D', 'Coach D', 'Country D'),
                                                      ('Team E', 'Coach E', 'Country E');
INSERT INTO player (full_name, date_of_birth, country, position, jersey_number, photo, height, weight, email, phone, IDTeam, contract_start_date, contract_end_date)
VALUES
    ('John Doe', '1990-05-15', 'USA', 'Forward', '10', 'base64encodedphoto', '180cm', '75kg', 'john.doe@example.com', '123456789', 1, '2022-01-01', '2023-12-31'),
    ('Alice Smith', '1995-08-20', 'Canada', 'Midfielder', '8', 'base64encodedphoto', '165cm', '60kg', 'alice.smith@example.com', '987654321', 1, '2021-12-01', '2024-11-30'),
    ('Bob Johnson', '1992-03-10', 'England', 'Defender', '5', 'base64encodedphoto', '185cm', '80kg', 'bob.johnson@example.com', '456123789', 2, '2023-06-15', '2025-06-14'),
    ('Emma Lee', '1997-11-25', 'Australia', 'Goalkeeper', '1', 'base64encodedphoto', '175cm', '70kg', 'emma.lee@example.com', '321654987', 2, '2022-10-01', '2024-09-30'),
    ('David Wang', '1993-07-18', 'China', 'Midfielder', '7', 'base64encodedphoto', '170cm', '68kg', 'david.wang@example.com', '789456123', 3, '2023-03-01', '2025-02-28');
