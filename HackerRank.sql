CREATE TABLE Hackers (
  hacker_id int,
  name varchar(255)
);

CREATE TABLE Submissions (
   submission_date date,
   submission_id int,
   hacker_id int,
   score int
);

INSERT INTO Hackers (hacker_id, name)
VALUES 
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

INSERT INTO Submissions (submission_date, submission_id, hacker_id, score)
VALUES 
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 44364, 79722, 25),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 45),
('2016-03-04', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-05', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);


SELECT 
  s.submission_date, 
  COUNT(DISTINCT s.hacker_id) AS num_unique_hackers,
  MAX(submissions_per_hacker) AS max_submissions,
  SUBSTRING_INDEX(GROUP_CONCAT(s.hacker_id ORDER BY submissions_per_hacker DESC, s.hacker_id ASC), ',', 1) AS top_hacker_id,
  h.name AS top_hacker_name
FROM (
  SELECT 
    submission_date,
    hacker_id,
    COUNT(*) AS submissions_per_hacker
  FROM Submissions
  GROUP BY submission_date, hacker_id
) AS submissions_per_day
INNER JOIN Submissions AS s ON s.submission_date = submissions_per_day.submission_date AND s.hacker_id = submissions_per_day.hacker_id AND s.score = submissions_per_day.submissions_per_hacker
INNER JOIN Hackers AS h ON h.hacker_id = SUBSTRING_INDEX(GROUP_CONCAT(s.hacker_id ORDER BY submissions_per_hacker DESC, s.hacker_id ASC), ',', 1)
GROUP BY s.submission_date
ORDER BY s.submission_date;
