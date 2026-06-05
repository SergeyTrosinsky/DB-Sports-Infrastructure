-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 05 2026 г., 17:24
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `SportInfrastruktura`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `CompetitionSchedule` ()   BEGIN
    SELECT
        s.Nazvanie AS 'Соревнование',
        v.Nazvanie AS 'Вид спорта',
        o.FIO AS 'Организатор',
        s.Data_provedeniya AS 'Дата'
    FROM Sostyazaniya s
    LEFT JOIN Vidy_sporta v
        ON s.Vid_sporta_ID = v.ID
    LEFT JOIN Organizatory_sorevnovaniy o
        ON s.ID_Organizatory_sorevnovaniy =
           o.ID_organizatora_sorevnovaniy
    ORDER BY s.Data_provedeniya;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `GetAllClubStats` ()   BEGIN
    SELECT
        k.Nazvanie AS 'Клуб',
        COUNT(s.ID) AS 'Количество спортсменов'
    FROM Sportivnye_kluby k
    LEFT JOIN Sportsmeny s
        ON k.ID_sportivnogo_kluba =
           s.ID_sportivnogo_kluba
    GROUP BY
        k.ID_sportivnogo_kluba,
        k.Nazvanie
    ORDER BY COUNT(s.ID) DESC;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `GetClubStatistics` (IN `club_name` VARCHAR(100))   BEGIN
    SELECT
        k.Nazvanie AS 'Клуб',
        COUNT(s.ID) AS 'Количество спортсменов',
        SUM(CASE WHEN s.Pol='muzhskoy' THEN 1 ELSE 0 END)
            AS 'Мужчин',
        SUM(CASE WHEN s.Pol='zhenskiy' THEN 1 ELSE 0 END)
            AS 'Женщин'
    FROM Sportivnye_kluby k
    LEFT JOIN Sportsmeny s
        ON k.ID_sportivnogo_kluba =
           s.ID_sportivnogo_kluba
    WHERE k.Nazvanie = club_name
    GROUP BY
        k.ID_sportivnogo_kluba,
        k.Nazvanie;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `GetCompetitionWinners` (IN `competition_name` VARCHAR(100))   BEGIN
    SELECT
        sp.FIO AS 'Спортсмен',
        r.Mesto AS 'Место'
    FROM Rezultaty_uchastiya r
    JOIN Sportsmeny sp
        ON r.ID_sportsmena = sp.ID
    JOIN Sostyazaniya s
        ON r.ID_sostyazaniya = s.ID
    WHERE s.Nazvanie = competition_name
      AND r.Mesto <= 3
    ORDER BY r.Mesto;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `GetSportsmenBySport` (IN `sport_name` VARCHAR(100))   BEGIN
    SELECT DISTINCT
        sp.FIO AS 'Спортсмен',
        sp.Razryad AS 'Разряд',
        k.Nazvanie AS 'Клуб'
    FROM Sportsmeny sp
    JOIN Rezultaty_uchastiya r
        ON sp.ID = r.ID_sportsmena
    JOIN Sostyazaniya s
        ON r.ID_sostyazaniya = s.ID
    JOIN Vidy_sporta v
        ON s.Vid_sporta_ID = v.ID
    LEFT JOIN Sportivnye_kluby k
        ON sp.ID_sportivnogo_kluba =
           k.ID_sportivnogo_kluba
    WHERE v.Nazvanie = sport_name
    ORDER BY sp.FIO;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Nagrazhdenie`
--

CREATE TABLE `Nagrazhdenie` (
  `ID` int NOT NULL,
  `ID_rezultata` int DEFAULT NULL,
  `Nazvanie_nagrady` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Nagrazhdenie`
--

INSERT INTO `Nagrazhdenie` (`ID`, `ID_rezultata`, `Nazvanie_nagrady`) VALUES
(1, 1, 'Золотая медаль'),
(2, 3, 'Золотая медаль'),
(3, 6, 'Золотая медаль'),
(4, 7, 'Золотая медаль'),
(6, 11, 'Золотая медаль');

-- --------------------------------------------------------

--
-- Структура таблицы `Organizatory_sorevnovaniy`
--

CREATE TABLE `Organizatory_sorevnovaniy` (
  `ID_organizatora_sorevnovaniy` int NOT NULL,
  `FIO` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Organizatory_sorevnovaniy`
--

INSERT INTO `Organizatory_sorevnovaniy` (`ID_organizatora_sorevnovaniy`, `FIO`) VALUES
(1, 'Иванова Наталья'),
(2, 'Громов Алексей');

-- --------------------------------------------------------

--
-- Структура таблицы `Rezultaty_uchastiya`
--

CREATE TABLE `Rezultaty_uchastiya` (
  `ID` int NOT NULL,
  `ID_sostyazaniya` int DEFAULT NULL,
  `ID_sportsmena` int DEFAULT NULL,
  `Mesto` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Rezultaty_uchastiya`
--

INSERT INTO `Rezultaty_uchastiya` (`ID`, `ID_sostyazaniya`, `ID_sportsmena`, `Mesto`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 6, 1),
(4, 2, 7, 3),
(5, 3, 3, 2),
(6, 3, 9, 1),
(7, 4, 4, 1),
(8, 4, 10, 2),
(11, 1, 2, 1);

--
-- Триггеры `Rezultaty_uchastiya`
--
DELIMITER $$
CREATE TRIGGER `trg_auto_nagrada` AFTER INSERT ON `Rezultaty_uchastiya` FOR EACH ROW BEGIN

    IF NEW.Mesto=1 THEN

        INSERT INTO Nagrazhdenie(ID_rezultata,Nazvanie_nagrady)

        VALUES(NEW.ID,'Золотая медаль');

    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_upgrade_razryad` AFTER INSERT ON `Rezultaty_uchastiya` FOR EACH ROW BEGIN

    IF NEW.Mesto=1 THEN

        UPDATE Sportsmeny SET Razryad='МС'

        WHERE ID=NEW.ID_sportsmena;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Sostyazaniya`
--

CREATE TABLE `Sostyazaniya` (
  `ID` int NOT NULL,
  `Nazvanie` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL,
  `Sportivnoe_sooruzhenie_ID` int DEFAULT NULL,
  `ID_Organizatory_sorevnovaniy` int DEFAULT NULL,
  `Data_provedeniya` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sostyazaniya`
--

INSERT INTO `Sostyazaniya` (`ID`, `Nazvanie`, `Vid_sporta_ID`, `Sportivnoe_sooruzhenie_ID`, `ID_Organizatory_sorevnovaniy`, `Data_provedeniya`) VALUES
(1, 'Кубок города по футболу', 1, 1, 1, '2025-04-01'),
(2, 'Открытый турнир по теннису', 2, 2, 2, '2025-04-10'),
(3, 'Чемпионат по легкой атлетике', 3, 3, 1, '2025-04-15'),
(4, 'Баскетбольная лига', 4, 4, 2, '2025-04-20');

--
-- Триггеры `Sostyazaniya`
--
DELIMITER $$
CREATE TRIGGER `trg_backup_sostyazanie` BEFORE DELETE ON `Sostyazaniya` FOR EACH ROW BEGIN

    INSERT INTO Sostyazaniya_backup

    SELECT * FROM Sostyazaniya WHERE ID=OLD.ID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Sostyazaniya_backup`
--

CREATE TABLE `Sostyazaniya_backup` (
  `ID` int NOT NULL DEFAULT '0',
  `Nazvanie` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL,
  `Sportivnoe_sooruzhenie_ID` int DEFAULT NULL,
  `ID_Organizatory_sorevnovaniy` int DEFAULT NULL,
  `Data_provedeniya` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sostyazaniya_backup`
--

INSERT INTO `Sostyazaniya_backup` (`ID`, `Nazvanie`, `Vid_sporta_ID`, `Sportivnoe_sooruzhenie_ID`, `ID_Organizatory_sorevnovaniy`, `Data_provedeniya`) VALUES
(5, 'Первенство по плаванию', 5, 5, 1, '2025-04-25');

-- --------------------------------------------------------

--
-- Структура таблицы `Sportivnoe_sooruzhenie`
--

CREATE TABLE `Sportivnoe_sooruzhenie` (
  `ID` int NOT NULL,
  `Nazvanie` varchar(100) NOT NULL,
  `Tip_ID` int DEFAULT NULL,
  `Vmestimost` int DEFAULT NULL,
  `Tip_pokrytiya` varchar(50) DEFAULT NULL,
  `Ploshad` float DEFAULT NULL,
  `Adres` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sportivnoe_sooruzhenie`
--

INSERT INTO `Sportivnoe_sooruzhenie` (`ID`, `Nazvanie`, `Tip_ID`, `Vmestimost`, `Tip_pokrytiya`, `Ploshad`, `Adres`) VALUES
(1, 'Центральный стадион', 1, 20000, NULL, 15000, 'ул. Ленина 1'),
(2, 'Теннисный корт №1', 2, NULL, 'Грунт', 500, 'ул. Спортивная 5'),
(3, 'Легкоатлетический манеж', 3, 1000, NULL, 3000, 'пр. Мира 10'),
(4, 'Баскетбольный зал', 4, 800, NULL, 1200, 'ул. Гагарина 12'),
(5, 'Городской бассейн', 5, 600, NULL, 2000, 'ул. Победы 7');

--
-- Триггеры `Sportivnoe_sooruzhenie`
--
DELIMITER $$
CREATE TRIGGER `trg_check_sooruzhenie` BEFORE INSERT ON `Sportivnoe_sooruzhenie` FOR EACH ROW BEGIN

    IF NEW.Vmestimost IS NULL AND NEW.Tip_ID = 1 THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT='Для стадиона обязательна вместимость';

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Sportivnye_kluby`
--

CREATE TABLE `Sportivnye_kluby` (
  `ID_sportivnogo_kluba` int NOT NULL,
  `Nazvanie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sportivnye_kluby`
--

INSERT INTO `Sportivnye_kluby` (`ID_sportivnogo_kluba`, `Nazvanie`) VALUES
(1, 'Динамо'),
(3, 'Олимп'),
(2, 'Спартак'),
(4, 'Юность');

-- --------------------------------------------------------

--
-- Структура таблицы `Sportsmeny`
--

CREATE TABLE `Sportsmeny` (
  `ID` int NOT NULL,
  `FIO` varchar(100) NOT NULL,
  `Razryad` varchar(50) DEFAULT NULL,
  `Pol` enum('muzhskoy','zhenskiy') DEFAULT NULL,
  `ID_sportivnogo_kluba` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sportsmeny`
--

INSERT INTO `Sportsmeny` (`ID`, `FIO`, `Razryad`, `Pol`, `ID_sportivnogo_kluba`) VALUES
(1, 'Иванов Иван', 'МС', 'muzhskoy', 1),
(2, 'Петров Петр', 'МС', 'muzhskoy', 2),
(3, 'Сидоров Алексей', 'КМС', 'muzhskoy', 3),
(4, 'Кузнецов Дмитрий', 'МС', 'muzhskoy', 1),
(5, 'Смирнов Андрей', '3 разряд', 'muzhskoy', 4),
(6, 'Попова Анна', 'МС', 'zhenskiy', 2),
(7, 'Козлова Мария', 'КМС', 'zhenskiy', 3),
(8, 'Морозова Елена', 'МС', 'zhenskiy', 1),
(9, 'Волков Сергей', 'МС', 'muzhskoy', 4),
(10, 'Соколова Дарья', '3 разряд', 'zhenskiy', 2);

--
-- Триггеры `Sportsmeny`
--
DELIMITER $$
CREATE TRIGGER `trg_log_razryad` AFTER UPDATE ON `Sportsmeny` FOR EACH ROW BEGIN

    IF OLD.Razryad<>NEW.Razryad THEN

        INSERT INTO Sportsmeny_log(ID_sportsmena,Old_Razryad,New_Razryad,Action_type)

        VALUES(OLD.ID,OLD.Razryad,NEW.Razryad,'UPDATE');

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Sportsmeny_log`
--

CREATE TABLE `Sportsmeny_log` (
  `ID_log` int NOT NULL,
  `ID_sportsmena` int DEFAULT NULL,
  `Old_Razryad` varchar(50) DEFAULT NULL,
  `New_Razryad` varchar(50) DEFAULT NULL,
  `Action_type` varchar(20) DEFAULT NULL,
  `Log_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Sportsmeny_log`
--

INSERT INTO `Sportsmeny_log` (`ID_log`, `ID_sportsmena`, `Old_Razryad`, `New_Razryad`, `Action_type`, `Log_date`) VALUES
(1, 1, 'КМС', 'МС', 'UPDATE', '2026-02-11 11:54:28'),
(2, 6, '1 разряд', 'МС', 'UPDATE', '2026-02-11 11:54:28'),
(3, 9, '1 разряд', 'МС', 'UPDATE', '2026-02-11 11:54:28'),
(4, 4, 'КМС', 'МС', 'UPDATE', '2026-02-11 11:54:28'),
(5, 8, '2 разряд', 'МС', 'UPDATE', '2026-02-11 11:54:28'),
(6, 2, '1 разряд', 'МС', 'UPDATE', '2026-06-05 09:40:24'),
(7, 3, '2 разряд', 'КМС', 'UPDATE', '2026-06-05 09:51:24');

-- --------------------------------------------------------

--
-- Структура таблицы `Tip_sooruzheniya`
--

CREATE TABLE `Tip_sooruzheniya` (
  `ID` int NOT NULL,
  `Nazvanie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Tip_sooruzheniya`
--

INSERT INTO `Tip_sooruzheniya` (`ID`, `Nazvanie`) VALUES
(5, 'Бассейн'),
(2, 'Корт'),
(3, 'Манеж'),
(4, 'Спортивный зал'),
(1, 'Стадион');

-- --------------------------------------------------------

--
-- Структура таблицы `Trenery`
--

CREATE TABLE `Trenery` (
  `ID` int NOT NULL,
  `FIO` varchar(100) NOT NULL,
  `Vid_sporta_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Trenery`
--

INSERT INTO `Trenery` (`ID`, `FIO`, `Vid_sporta_ID`) VALUES
(1, 'Орлов Сергей', 1),
(2, 'Тихонов Павел', 2),
(3, 'Зайцев Игорь', 3),
(4, 'Лебедев Максим', 4),
(5, 'Крылова Ольга', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `Trenirovki`
--

CREATE TABLE `Trenirovki` (
  `ID_trenirovki` int NOT NULL,
  `ID_trenera` int DEFAULT NULL,
  `ID_sportsmena` int DEFAULT NULL,
  `ID_vida_sporta` int DEFAULT NULL,
  `Data_nachala` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Trenirovki`
--

INSERT INTO `Trenirovki` (`ID_trenirovki`, `ID_trenera`, `ID_sportsmena`, `ID_vida_sporta`, `Data_nachala`) VALUES
(1, 1, 1, 1, '2025-01-10'),
(2, 1, 2, 1, '2025-01-12'),
(3, 2, 6, 2, '2025-02-01'),
(4, 2, 7, 2, '2025-02-03'),
(5, 3, 3, 3, '2025-03-01'),
(6, 4, 4, 4, '2025-03-05'),
(7, 5, 8, 5, '2025-03-10'),
(8, 3, 9, 3, '2025-03-12'),
(9, 4, 10, 4, '2025-03-15'),
(10, 5, 5, 5, '2025-03-20');

--
-- Триггеры `Trenirovki`
--
DELIMITER $$
CREATE TRIGGER `trg_check_trener` BEFORE INSERT ON `Trenirovki` FOR EACH ROW BEGIN

    DECLARE v INT;

    SELECT Vid_sporta_ID INTO v FROM Trenery WHERE ID=NEW.ID_trenera;

    IF v <> NEW.ID_vida_sporta THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT='Тренер не ведет этот вид спорта';

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Vidy_sporta`
--

CREATE TABLE `Vidy_sporta` (
  `ID` int NOT NULL,
  `Nazvanie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Vidy_sporta`
--

INSERT INTO `Vidy_sporta` (`ID`, `Nazvanie`) VALUES
(4, 'Баскетбол'),
(3, 'Легкая атлетика'),
(5, 'Плавание'),
(2, 'Теннис'),
(1, 'Футбол');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_prizery`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `view_prizery` (
`FIO` varchar(100)
,`Mesto` int
,`Nazvanie_nagrady` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_sooruzheniya`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `view_sooruzheniya` (
`Nazvanie` varchar(100)
,`Tip` varchar(50)
,`Vmestimost` int
,`Tip_pokrytiya` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_sorevnovaniya_period`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `view_sorevnovaniya_period` (
`Nazvanie` varchar(100)
,`Data_provedeniya` date
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_sportsmeny_vid`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `view_sportsmeny_vid` (
`FIO` varchar(100)
,`Razryad` varchar(50)
,`Vid_sporta` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_trenery_po_vidu`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `view_trenery_po_vidu` (
`FIO` varchar(100)
,`Nazvanie` varchar(50)
);

-- --------------------------------------------------------

--
-- Структура для представления `view_prizery`
--
DROP TABLE IF EXISTS `view_prizery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_prizery`  AS SELECT `s`.`FIO` AS `FIO`, `r`.`Mesto` AS `Mesto`, `n`.`Nazvanie_nagrady` AS `Nazvanie_nagrady` FROM ((`rezultaty_uchastiya` `r` join `sportsmeny` `s` on((`r`.`ID_sportsmena` = `s`.`ID`))) left join `nagrazhdenie` `n` on((`r`.`ID` = `n`.`ID_rezultata`))) WHERE (`r`.`Mesto` <= 3)  ;

-- --------------------------------------------------------

--
-- Структура для представления `view_sooruzheniya`
--
DROP TABLE IF EXISTS `view_sooruzheniya`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_sooruzheniya`  AS SELECT `ss`.`Nazvanie` AS `Nazvanie`, `ts`.`Nazvanie` AS `Tip`, `ss`.`Vmestimost` AS `Vmestimost`, `ss`.`Tip_pokrytiya` AS `Tip_pokrytiya` FROM (`sportivnoe_sooruzhenie` `ss` join `tip_sooruzheniya` `ts` on((`ss`.`Tip_ID` = `ts`.`ID`)))  ;

-- --------------------------------------------------------

--
-- Структура для представления `view_sorevnovaniya_period`
--
DROP TABLE IF EXISTS `view_sorevnovaniya_period`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_sorevnovaniya_period`  AS SELECT `sostyazaniya`.`Nazvanie` AS `Nazvanie`, `sostyazaniya`.`Data_provedeniya` AS `Data_provedeniya` FROM `sostyazaniya``sostyazaniya`  ;

-- --------------------------------------------------------

--
-- Структура для представления `view_sportsmeny_vid`
--
DROP TABLE IF EXISTS `view_sportsmeny_vid`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_sportsmeny_vid`  AS SELECT `s`.`FIO` AS `FIO`, `s`.`Razryad` AS `Razryad`, `v`.`Nazvanie` AS `Vid_sporta` FROM ((`sportsmeny` `s` join `trenirovki` `t` on((`s`.`ID` = `t`.`ID_sportsmena`))) join `vidy_sporta` `v` on((`t`.`ID_vida_sporta` = `v`.`ID`)))  ;

-- --------------------------------------------------------

--
-- Структура для представления `view_trenery_po_vidu`
--
DROP TABLE IF EXISTS `view_trenery_po_vidu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `view_trenery_po_vidu`  AS SELECT `tr`.`FIO` AS `FIO`, `v`.`Nazvanie` AS `Nazvanie` FROM (`trenery` `tr` join `vidy_sporta` `v` on((`tr`.`Vid_sporta_ID` = `v`.`ID`)))  ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Nagrazhdenie`
--
ALTER TABLE `Nagrazhdenie`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_rezultata` (`ID_rezultata`);

--
-- Индексы таблицы `Organizatory_sorevnovaniy`
--
ALTER TABLE `Organizatory_sorevnovaniy`
  ADD PRIMARY KEY (`ID_organizatora_sorevnovaniy`);

--
-- Индексы таблицы `Rezultaty_uchastiya`
--
ALTER TABLE `Rezultaty_uchastiya`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_sostyazaniya` (`ID_sostyazaniya`),
  ADD KEY `ID_sportsmena` (`ID_sportsmena`);

--
-- Индексы таблицы `Sostyazaniya`
--
ALTER TABLE `Sostyazaniya`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Vid_sporta_ID` (`Vid_sporta_ID`),
  ADD KEY `Sportivnoe_sooruzhenie_ID` (`Sportivnoe_sooruzhenie_ID`),
  ADD KEY `ID_Organizatory_sorevnovaniy` (`ID_Organizatory_sorevnovaniy`);

--
-- Индексы таблицы `Sportivnoe_sooruzhenie`
--
ALTER TABLE `Sportivnoe_sooruzhenie`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Tip_ID` (`Tip_ID`);

--
-- Индексы таблицы `Sportivnye_kluby`
--
ALTER TABLE `Sportivnye_kluby`
  ADD PRIMARY KEY (`ID_sportivnogo_kluba`),
  ADD UNIQUE KEY `Nazvanie` (`Nazvanie`);

--
-- Индексы таблицы `Sportsmeny`
--
ALTER TABLE `Sportsmeny`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_sportivnogo_kluba` (`ID_sportivnogo_kluba`);

--
-- Индексы таблицы `Sportsmeny_log`
--
ALTER TABLE `Sportsmeny_log`
  ADD PRIMARY KEY (`ID_log`);

--
-- Индексы таблицы `Tip_sooruzheniya`
--
ALTER TABLE `Tip_sooruzheniya`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazvanie` (`Nazvanie`);

--
-- Индексы таблицы `Trenery`
--
ALTER TABLE `Trenery`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Vid_sporta_ID` (`Vid_sporta_ID`);

--
-- Индексы таблицы `Trenirovki`
--
ALTER TABLE `Trenirovki`
  ADD PRIMARY KEY (`ID_trenirovki`),
  ADD KEY `ID_trenera` (`ID_trenera`),
  ADD KEY `ID_sportsmena` (`ID_sportsmena`),
  ADD KEY `ID_vida_sporta` (`ID_vida_sporta`);

--
-- Индексы таблицы `Vidy_sporta`
--
ALTER TABLE `Vidy_sporta`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazvanie` (`Nazvanie`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Nagrazhdenie`
--
ALTER TABLE `Nagrazhdenie`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Organizatory_sorevnovaniy`
--
ALTER TABLE `Organizatory_sorevnovaniy`
  MODIFY `ID_organizatora_sorevnovaniy` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Rezultaty_uchastiya`
--
ALTER TABLE `Rezultaty_uchastiya`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `Sostyazaniya`
--
ALTER TABLE `Sostyazaniya`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Sportivnoe_sooruzhenie`
--
ALTER TABLE `Sportivnoe_sooruzhenie`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Sportivnye_kluby`
--
ALTER TABLE `Sportivnye_kluby`
  MODIFY `ID_sportivnogo_kluba` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Sportsmeny`
--
ALTER TABLE `Sportsmeny`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `Sportsmeny_log`
--
ALTER TABLE `Sportsmeny_log`
  MODIFY `ID_log` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `Tip_sooruzheniya`
--
ALTER TABLE `Tip_sooruzheniya`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Trenery`
--
ALTER TABLE `Trenery`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Trenirovki`
--
ALTER TABLE `Trenirovki`
  MODIFY `ID_trenirovki` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `Vidy_sporta`
--
ALTER TABLE `Vidy_sporta`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Nagrazhdenie`
--
ALTER TABLE `Nagrazhdenie`
  ADD CONSTRAINT `nagrazhdenie_ibfk_1` FOREIGN KEY (`ID_rezultata`) REFERENCES `Rezultaty_uchastiya` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Rezultaty_uchastiya`
--
ALTER TABLE `Rezultaty_uchastiya`
  ADD CONSTRAINT `rezultaty_uchastiya_ibfk_1` FOREIGN KEY (`ID_sostyazaniya`) REFERENCES `Sostyazaniya` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `rezultaty_uchastiya_ibfk_2` FOREIGN KEY (`ID_sportsmena`) REFERENCES `Sportsmeny` (`ID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Sostyazaniya`
--
ALTER TABLE `Sostyazaniya`
  ADD CONSTRAINT `sostyazaniya_ibfk_1` FOREIGN KEY (`Vid_sporta_ID`) REFERENCES `Vidy_sporta` (`ID`),
  ADD CONSTRAINT `sostyazaniya_ibfk_2` FOREIGN KEY (`Sportivnoe_sooruzhenie_ID`) REFERENCES `Sportivnoe_sooruzhenie` (`ID`),
  ADD CONSTRAINT `sostyazaniya_ibfk_3` FOREIGN KEY (`ID_Organizatory_sorevnovaniy`) REFERENCES `Organizatory_sorevnovaniy` (`ID_organizatora_sorevnovaniy`);

--
-- Ограничения внешнего ключа таблицы `Sportivnoe_sooruzhenie`
--
ALTER TABLE `Sportivnoe_sooruzhenie`
  ADD CONSTRAINT `sportivnoe_sooruzhenie_ibfk_1` FOREIGN KEY (`Tip_ID`) REFERENCES `Tip_sooruzheniya` (`ID`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `Sportsmeny`
--
ALTER TABLE `Sportsmeny`
  ADD CONSTRAINT `sportsmeny_ibfk_1` FOREIGN KEY (`ID_sportivnogo_kluba`) REFERENCES `Sportivnye_kluby` (`ID_sportivnogo_kluba`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `Trenery`
--
ALTER TABLE `Trenery`
  ADD CONSTRAINT `trenery_ibfk_1` FOREIGN KEY (`Vid_sporta_ID`) REFERENCES `Vidy_sporta` (`ID`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `Trenirovki`
--
ALTER TABLE `Trenirovki`
  ADD CONSTRAINT `trenirovki_ibfk_1` FOREIGN KEY (`ID_trenera`) REFERENCES `Trenery` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `trenirovki_ibfk_2` FOREIGN KEY (`ID_sportsmena`) REFERENCES `Sportsmeny` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `trenirovki_ibfk_3` FOREIGN KEY (`ID_vida_sporta`) REFERENCES `Vidy_sporta` (`ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
