# Sports Infrastructure Database (MySQL)

## Описание проекта

База данных «SportInfrastruktura» предназначена для автоматизации управления спортивной инфраструктурой города. Система позволяет вести учёт спортивных сооружений, спортсменов, тренеров, спортивных клубов, соревнований и их результатов. Предназначена для использования спортивными комитетами, администрациями спортивных объектов, тренерами, организаторами мероприятий и спортсменами.

База данных предназначена для хранения и обработки информации о:

- спортсменах;
    
- тренерах;
    
- спортивных клубах;
    
- спортивных объектах;
    
- соревнованиях;
    
- тренировках;
    
- наградах;
    
- результатах участия спортсменов.
    

Проект демонстрирует навыки проектирования структуры БД, нормализации данных, создания связей между таблицами, написания SQL-запросов, представлений (VIEW), триггеров, логов и хранимых процедур.

---

## Используемые технологии

- MySQL
    
- phpMyAdmin
    
- SQL
    
- Stored Procedures
    
- Views
    
- Triggers
    

---

## Структура базы данных

Архитектура базы данных включает 13 взаимосвязанных таблиц, описывающих следующие основные сущности:

|Таблица|Назначение|
|---|---|
|Sportsmeny|Спортсмены|
|Trenery|Тренеры|
|Sportivnye_kluby|Спортивные клубы|
|Sportivnye_obekty|Спортивные объекты|
|Vidy_sporta|Виды спорта|
|Sostyazaniya|Соревнования|
|Rezultaty_uchastiya|Результаты участия|
|Nagrazhdenie|Награды|
|Trenirovki|Тренировки|
|Organizatory|Организаторы|
|Sorevnovaniya_organizatory|Связь соревнований и организаторов|
|Backup_sostyazaniya|Архив соревнований|
|Log_razryadov|Журнал изменений разрядов|

---

## ER-диаграмма

Ниже представлена логическая схема базы данных.

<img width="1525" height="1199" alt="изображение" src="https://github.com/user-attachments/assets/1051244e-4286-4f47-836e-830773f90ae4" />

---

## Структура базы данных

Общий вид базы данных в phpMyAdmin.

<img width="1016" height="909" alt="изображение" src="https://github.com/user-attachments/assets/bf18a457-c27f-46e9-95f7-83d1cd939b18" />

---

# Структура таблиц

## Таблица Sportsmeny

Хранит сведения о спортсменах.

Скрин:

```
SELECT * FROM Sportsmeny;
```

<img width="528" height="332" alt="изображение" src="https://github.com/user-attachments/assets/afd7e061-a946-480b-ab81-0c22a2b3d2d6" />

---

## Таблица Sportivnye_kluby

Содержит перечень спортивных клубов.

 Скрин:

```sql
SELECT * FROM Sportivnye_kluby;
```

<img width="320" height="159" alt="изображение" src="https://github.com/user-attachments/assets/6b11c804-af04-40ac-8e32-bbaa13659a2d" />

---

## Таблица Vidy_sporta

Список видов спорта.

 Скрин:

```sql
SELECT * FROM Vidy_sporta;
```

<img width="221" height="179" alt="изображение" src="https://github.com/user-attachments/assets/58530238-166d-4f49-b8c3-fb2c7dc85488" />

---

## Таблица Trenery

Информация о тренерах.

 Скрин:

```sql
SELECT * FROM Trenery;
```

<img width="331" height="177" alt="изображение" src="https://github.com/user-attachments/assets/f3081c7c-e670-48e8-9288-bd4460706a0a" />

---

## Таблица Trenirovki

Данные о тренировках спортсменов.

 Скрин:

```sql
SELECT * FROM Trenirovki;
```

<img width="581" height="323" alt="изображение" src="https://github.com/user-attachments/assets/07cbcb4d-d97a-4df2-851b-5da46718e283" />

---

## Таблица Sostyazaniya

Информация о соревнованиях.

 Скрин:

```sql
SELECT * FROM Sostyazaniya;
```

<img width="931" height="186" alt="изображение" src="https://github.com/user-attachments/assets/04857336-054d-4d9d-a2a0-c48b59312202" />

---

## Таблица Rezultaty_uchastiya

Результаты выступлений спортсменов.

 Скрин:

```sql
SELECT * FROM Rezultaty_uchastiya;
```

<img width="395" height="315" alt="изображение" src="https://github.com/user-attachments/assets/abd3f2ac-9313-4b43-a1ce-0552c8d9f409" />

---

## Таблица Nagrazhdenie

Сведения о наградах.

 Скрин:

```sql
SELECT * FROM Nagrazhdenie;
```

<img width="339" height="178" alt="изображение" src="https://github.com/user-attachments/assets/531377d0-5283-42ac-98d1-4e34025b43d0" />

---

## Таблица Organizatory_sorevnovaniy

Организаторы соревнований.

 Скрин:

```sql
SELECT * FROM Organizatory_sorevnovaniy;
```

<img width="404" height="90" alt="изображение" src="https://github.com/user-attachments/assets/15eadb42-cd62-4ddf-8ba2-3afd162b56f6" />

---

## Таблица Sportivnoe_sooruzhenie

Спортивные сооружения.

 Скрин:

```sql
SELECT * FROM Sportivnoe_sooruzhenie;
```

<img width="709" height="178" alt="изображение" src="https://github.com/user-attachments/assets/ce3e4f25-b902-46d4-9977-cb2d48a888a6" />

---

## Таблица Tip_sooruzheniya

Типы спортивных объектов.

 Скрин:

```sql
SELECT * FROM Tip_sooruzheniya;
```

<img width="247" height="180" alt="изображение" src="https://github.com/user-attachments/assets/7db25a54-50a7-4481-9135-711c50e9304f" />

---

## Таблица Sportsmeny_log

Журнал изменений разрядов.

 Скрин:

```sql
SELECT * FROM Sportsmeny_log;
```

<img width="666" height="177" alt="изображение" src="https://github.com/user-attachments/assets/e59f43a6-ca82-464b-8664-c28b899eacca" />

---

## Таблица Sostyazaniya_backup

Архив удалённых соревнований.

 Скрин:

```sql
SELECT * FROM Sostyazaniya_backup;
```

<img width="704" height="152" alt="изображение" src="https://github.com/user-attachments/assets/4311d245-8c93-4537-a708-e195f8b2932d" />

---

# Представления (VIEW)

## view_prizery

Список призёров соревнований.

```sql
SELECT * FROM view_prizery;
```

 Скрин результата.

<img width="320" height="318" alt="изображение" src="https://github.com/user-attachments/assets/2565f312-b10d-4476-be01-dc38adcd8bf0" />

---

## view_sooruzheniya

Информация о спортивных сооружениях и их типах.

```sql
SELECT * FROM view_sooruzheniya;
```

 Скрин результата.

<img width="554" height="175" alt="изображение" src="https://github.com/user-attachments/assets/95240e1c-bba6-4159-a76f-e34c11f8da4f" />

---

## view_sportsmeny_vid

Спортсмены по видам спорта.

```sql
SELECT * FROM view_sportsmeny_vid;
```

 Скрин результата.

<img width="388" height="317" alt="изображение" src="https://github.com/user-attachments/assets/1787804b-1095-4290-982b-b56eff7a50b7" />

---

## view_trenery_po_vidu

Тренеры и специализации.

```sql
SELECT * FROM view_trenery_po_vidu;
```

 Скрин результата.

<img width="307" height="178" alt="изображение" src="https://github.com/user-attachments/assets/995642a6-18f2-4214-8364-5a67a2df0159" />

---

## view_sorevnovaniya_period

Список соревнований по датам проведения.

```sql
SELECT * FROM view_sorevnovaniya_period;
```

 Скрин результата.

<img width="418" height="177" alt="изображение" src="https://github.com/user-attachments/assets/6567e9c9-39b3-4f0d-8e8d-05d473d311d7" />

---

# Триггеры

Список триггеров:

```sql
SHOW TRIGGERS;
```

<img width="1538" height="784" alt="изображение" src="https://github.com/user-attachments/assets/91559eec-39b2-4d65-bcec-feee80d0d53c" />

---
## trg_auto_nagrada

Автоматически создаёт запись о награде победителю.

### Проверка

```sql
INSERT INTO Rezultaty_uchastiya
(ID_sostyazaniya, ID_sportsmena, Mesto)
VALUES (1,2,1);
```

<img width="670" height="175" alt="изображение" src="https://github.com/user-attachments/assets/333a041e-5754-4cbd-a241-fbe085d38a71" />

После этого:

```sql
SELECT * FROM Nagrazhdenie
ORDER BY ID DESC;
```

 Скрин до 

<img width="339" height="178" alt="изображение" src="https://github.com/user-attachments/assets/ee67ae63-bd93-4fcf-9e74-91a620fccbfd" />
 
 и после.

<img width="362" height="201" alt="изображение" src="https://github.com/user-attachments/assets/5491b03d-8d34-48c5-b207-dc8ce50450c7" />

---

## trg_upgrade_razryad

Автоматически присваивает разряд МС победителю.

Проверка:

```sql
SELECT * FROM Sportsmeny
WHERE ID=2;
```

Затем добавить результат с первым местом.
<img width="670" height="175" alt="изображение" src="https://github.com/user-attachments/assets/8e363c54-46a4-4ce4-8548-8e568c008413" />
 
 Изменение разряда. Скрин лога до и после:

<img width="675" height="242" alt="изображение" src="https://github.com/user-attachments/assets/890a7d4c-077c-4ac6-aee7-934908384535" />

---

## trg_log_razryad

Логирует изменение разрядов.

```sql
UPDATE Sportsmeny
SET Razryad='КМС'
WHERE ID=3;
```

<img width="402" height="137" alt="изображение" src="https://github.com/user-attachments/assets/102cff71-bc07-4db8-b823-e9bb91f7c7fb" />

Проверка:

```sql
SELECT * FROM Sportsmeny_log
ORDER BY ID_log DESC;
```

 Скрин результата.

<img width="688" height="227" alt="изображение" src="https://github.com/user-attachments/assets/ff489ebc-ed1b-4267-875c-a8558701e183" />

---

## trg_backup_sostyazanie

Создаёт резервную копию удалённого соревнования.

```sql
DELETE FROM Sostyazaniya
WHERE ID=5;
```

<img width="437" height="154" alt="изображение" src="https://github.com/user-attachments/assets/d3c585e1-9e60-4f58-bd49-d716c67cee37" />

Проверка:

```sql
SELECT * FROM Sostyazaniya_backup;
```

 Скрин результата.

<img width="829" height="72" alt="изображение" src="https://github.com/user-attachments/assets/3c50c1e5-9ea1-4e54-a4fb-a8e4a389c88b" />

---

## trg_check_sooruzhenie

Проверяет корректность вместимости стадиона.

```sql
INSERT INTO Sportivnoe_sooruzhenie
(Nazvanie, Tip_ID)
VALUES ('Тестовый стадион',1);
```

 Скрин ошибки:

<img width="404" height="303" alt="изображение" src="https://github.com/user-attachments/assets/a5892a8c-f96b-43b0-bafe-a8d1b4358dfb" />

---

## trg_check_trener

Проверяет соответствие тренера виду спорта.

```sql
INSERT INTO Trenirovki
(ID_trenera,ID_sportsmena,ID_vida_sporta)
VALUES (1,1,5);
```

 Скрин ошибки:

<img width="335" height="293" alt="изображение" src="https://github.com/user-attachments/assets/63a3b2a5-75cf-4579-a1cc-091162fbeb2e" />

---

## Хранимые процедуры

В базе данных реализованы хранимые процедуры для автоматизации работы с данными.

### GetClubStatistics

Возвращает статистику выбранного спортивного клуба.

```sql
CALL GetClubStatistics('Спартак');
```

<img width="496" height="262" alt="изображение" src="https://github.com/user-attachments/assets/6deecd0f-7031-450f-8ff2-39386dbaa400" />

---

### GetSportsmenBySport

Выводит спортсменов выбранного вида спорта.

```sql
CALL GetSportsmenBySport('Футбол');
```

<img width="326" height="298" alt="изображение" src="https://github.com/user-attachments/assets/bc7ecf3b-e4cc-45fe-947a-8f00093213d5" />

---

### GetCompetitionWinners

Возвращает призёров соревнования.

```sql
CALL GetCompetitionWinners('Кубок Москвы');
```

<img width="500" height="306" alt="изображение" src="https://github.com/user-attachments/assets/50f8ec5f-27e3-4c77-afcf-0bca5f8ed671" />

---

### CompetitionSchedule

Отображает календарь соревнований.

```sql
CALL CompetitionSchedule();
```

<img width="592" height="395" alt="изображение" src="https://github.com/user-attachments/assets/8a84be20-9dda-4d0c-acd1-b91bf7d3a51d" />

---

### GetAllClubStats

Формирует общий аналитический отчёт по спортивным клубам.

```sql
CALL GetAllClubStats();
```

<img width="303" height="367" alt="изображение" src="https://github.com/user-attachments/assets/8c72f75b-bbd5-402f-a82e-8ccce5c25f90" />

---

## Примеры SQL-запросов

## 1. Количество спортсменов в каждом клубе

```sql
SELECT
    sk.Nazvanie AS Klub,
    COUNT(s.ID) AS Kolichestvo_sportsmenov
FROM Sportivnye_kluby sk
LEFT JOIN Sportsmeny s
    ON sk.ID_sportivnogo_kluba = s.ID_sportivnogo_kluba
GROUP BY sk.ID_sportivnogo_kluba, sk.Nazvanie
ORDER BY Kolichestvo_sportsmenov DESC;
```

**Что показывает:** количество спортсменов по спортивным клубам.

<img width="268" height="149" alt="изображение" src="https://github.com/user-attachments/assets/52fccd11-0c75-4e52-be46-5258594fa622" />

---

## 2. Победители и призёры соревнований

```sql
SELECT
    so.Nazvanie AS Sorevnovanie,
    sp.FIO,
    ru.Mesto
FROM Rezultaty_uchastiya ru
JOIN Sportsmeny sp
    ON ru.ID_sportsmena = sp.ID
JOIN Sostyazaniya so
    ON ru.ID_sostyazaniya = so.ID
WHERE ru.Mesto <= 3
ORDER BY so.Nazvanie, ru.Mesto;
```

**Что показывает:** спортсменов, занявших призовые места.

<img width="378" height="311" alt="изображение" src="https://github.com/user-attachments/assets/2cda4eba-ae1f-4939-aff3-454f04d02be6" />

---

## 3. Список соревнований с видом спорта

```sql
SELECT
    s.Nazvanie AS Sorevnovanie,
    vs.Nazvanie AS Vid_sporta,
    s.Data_provedeniya
FROM Sostyazaniya s
JOIN Vidy_sporta vs
    ON s.Vid_sporta_ID = vs.ID
ORDER BY s.Data_provedeniya;
```

**Что показывает:** календарь соревнований.

<img width="465" height="173" alt="изображение" src="https://github.com/user-attachments/assets/f8c0b4f0-80b0-4937-a100-32512fcf17ec" />

---

## 4. Все спортивные сооружения

```sql
SELECT
    ss.Nazvanie,
    ts.Nazvanie AS Tip,
    ss.Vmestimost,
    ss.Adres
FROM Sportivnoe_sooruzhenie ss
JOIN Tip_sooruzheniya ts
    ON ss.Tip_ID = ts.ID;
```

**Что показывает:** спортивные объекты и их характеристики.

<img width="488" height="176" alt="изображение" src="https://github.com/user-attachments/assets/cdd046ba-122f-4ea9-b6d2-66215001e1b4" />

---

## 5. Тренеры и виды спорта

```sql
SELECT
    t.FIO,
    vs.Nazvanie AS Vid_sporta
FROM Trenery t
JOIN Vidy_sporta vs
    ON t.Vid_sporta_ID = vs.ID;
```

**Что показывает:** специализацию тренеров.

<img width="219" height="173" alt="изображение" src="https://github.com/user-attachments/assets/22c88494-e029-44ea-b784-857572ffcffe" />

---

## 6. История изменений разрядов спортсменов

```sql
SELECT
    ID_sportsmena,
    Old_Razryad,
    New_Razryad,
    Action_type,
    Log_date
FROM Sportsmeny_log;
```

**Что показывает:** работу триггера логирования.

<img width="607" height="181" alt="изображение" src="https://github.com/user-attachments/assets/ecbd2f1e-615f-493f-a66d-f061e45ecfe1" />

---

## 7. Полученные награды

```sql
SELECT
    sp.FIO,
    n.Nazvanie_nagrady
FROM Nagrazhdenie n
JOIN Rezultaty_uchastiya ru
    ON n.ID_rezultata = ru.ID
JOIN Sportsmeny sp
    ON ru.ID_sportsmena = sp.ID;
```

**Результат выполнения:** демонстрация автоматического присвоения награды с помощью триггера `trg_auto_nagrada`.

<img width="261" height="174" alt="изображение" src="https://github.com/user-attachments/assets/89c85ccb-1037-46cf-8629-835d0b69f020" />

---

## 8. Тренировки спортсменов

```sql
SELECT
    sp.FIO AS Sportsmen,
    tr.FIO AS Trener,
    vs.Nazvanie AS Vid_sporta,
    t.Data_nachala
FROM Trenirovki t
JOIN Sportsmeny sp
    ON t.ID_sportsmena = sp.ID
JOIN Trenery tr
    ON t.ID_trenera = tr.ID
JOIN Vidy_sporta vs
    ON t.ID_vida_sporta = vs.ID
ORDER BY t.Data_nachala;
```

**Что показывает:** связь спортсменов, тренеров и видов спорта.

<img width="479" height="310" alt="изображение" src="https://github.com/user-attachments/assets/e5d954c3-bcbb-486e-ba0b-df13d90d7e67" />

---
## Как запустить проект локально

Для работы с системой необходимо установить:

| Компонент         | Назначение                                            |
| ----------------- | ----------------------------------------------------- |
| Open Server Panel | Локальный веб-сервер с поддержкой Apache, PHP, MySQL. |
| phpMyAdmin        | Веб-интерфейс для администрирования базы данных.      |
##### Порядок загрузки данных и программ

1.    Скачайте и установите Open Server Panel с официального сайта.

2.    Запустите Open Server Panel от имени администратора.

3.    В трее нажмите на иконку Open Server, выберите «Дополнительно» → «phpMyAdmin».

4.    В окне авторизации введите:
		Пользователь: root
		Пароль: оставьте пустым

5.    В phpMyAdmin        создайте     новую         базу   данных       с      именем

SportInfrastruktura.

6.    Перейдите во вкладку «Импорт», выберите файл SportInfrastruktura.sql и нажмите «Вперёд».

7.    После успешного импорта база данных готова к использованию.

---
## Приобретенные компетенции:

- проектирования реляционных баз данных;
    
- нормализации данных;
    
- создания связей между таблицами;
    
- написания SQL-запросов различной сложности;
    
- разработки представлений (VIEW);
    
- разработки триггеров;
    
- создания хранимых процедур;
    
- работы с MySQL и phpMyAdmin;
    
- проектирования базы данных спортивной предметной области.
    

---
