create database quanlydoibong;
use quanlydoibong;

create table Team
(
	IDTeam int auto_increment primary key,
    TeamName nvarchar(255) not null,
    CoachName nvarchar(255) not null,
    Country nvarchar(255) not null
);

CREATE TABLE player
(
    IDPlayer int auto_increment primary key,
    FullName nvarchar(255) not null,
    DateOfBirth date not null,
    Country nvarchar(255) not null,
    Position nvarchar(255) not null,
    JerseyNumber nvarchar(15) not null,
    Photo longtext,
    Height nvarchar(25),
    Weight nvarchar(25),
    Email nvarchar(50),
    Phone nvarchar(50),
    IDTeam int,
    ContractStartDate date,
    ContractEndDate date,
    foreign key(IDTeam) references Team(IDTeam)
);

create table tournaments
(
	IDTournaments int auto_increment primary key,
    TournamentsName nvarchar(255) not null,
    StartDate date,
    EndDate date
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
create table goalAndCard
(
	IDGoals int auto_increment primary key,
    MatchID int,
    IDPlayer int,
    GoalTime time,
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

-- Chèn dữ liệu vào bảng Team
INSERT INTO Team (TeamName, CoachName, Country)
VALUES ('Manchester United', 'Ole Gunnar Solskjaer', 'England');
-- Chèn dữ liệu vào bảng Team
INSERT INTO Team (TeamName, CoachName, Country)
VALUES ('Real Madrid', 'Carlo Ancelotti', 'Spain');

-- Chèn dữ liệu vào bảng player
INSERT INTO player (FullName, DateOfBirth, Country, Position, JerseyNumber, Photo, Height, Weight, Email, Phone, IDTeam, ContractStartDate, ContractEndDate)
VALUES ('Cristiano Ronaldo', '1985-02-05', 'Portugal', 'Forward', '7', 'URL_anh', '187cm', '83kg', 'cr7@example.com', '123456789', 1, '2021-08-31', '2023-06-30');


-- Chèn dữ liệu vào bảng tournaments
INSERT INTO tournaments (TournamentsName, StartDate, EndDate)
VALUES ('Premier League', '2023-08-01', '2024-05-31');

-- Chèn dữ liệu vào bảng matches
INSERT INTO matches (IDTournaments, HomeTeamID, AwayTeamID, HomeTeamScore, AwayTeamScore, MatchDate, status, YellowCardsHomeTeam, RedCardsHomeTeam, YellowCardsAwayTeam, RedCardsAwayTeam, LoaiTranDau)
VALUES (1, 1, 2, 2, 1, '2024-03-10', 'Finished', 2, 0, 1, 0, 'League Match');

-- Chèn dữ liệu vào bảng goalAndCard
INSERT INTO goalAndCard (MatchID, IDPlayer, GoalTime, YellowCards, RedCards)
VALUES (1, 1, '60:00', 0, 0);

