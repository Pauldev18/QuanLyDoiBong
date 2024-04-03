create database quanlydoibong;
use quanlydoibong;

create table Team
(
    idteam int auto_increment primary key,
    team_name nvarchar(255) not null,
    coach_name nvarchar(255) not null,
    country nvarchar(255) not null,
    shows bit
);
create table AwayTeam
(
    id_away_team int auto_increment primary key,
    team_away_name nvarchar(255) not null,
    coach_away_name nvarchar(255) not null,
    country_away nvarchar(255) not null,
	shows bit
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
    shows bit,
    contract_start_date date,
    contract_end_date date,
    foreign key(idteam) references Team(idteam)
);

create table tournaments
(
    idtournaments int auto_increment primary key,
    tournaments_name nvarchar(255) not null,
    start_date date,
    end_date date,
	shows bit
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
    foreign key(away_teamid) references AwayTeam(id_away_team),
	shows bit
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
