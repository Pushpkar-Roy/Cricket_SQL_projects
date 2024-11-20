SELECT * FROM T20I

-- Q1 - Find the team with the highest number of wins in 2024 and the total matches it won.

SELECT winner, COUNT(winner) Total_wins
FROM T20I
GROUP BY winner
ORDER BY Total_wins DESC

-- Q2- Rank the team bases on the tottal number of win in 2024.

SELECT winner, COUNT(winner) AS Total_wins,
    RANK() OVER(ORDER BY COUNT(*) DESC) AS Rank_assigned
FROM T20I
WHERE winner NOT IN ('tied', 'no result')
GROUP BY winner
ORDER BY total_wins DESC

--Q3- Which team had the highest average winning margin ( in run), and what was the average, margin ?

SELECT winner,
   AVG(CAST(SUBSTRING(margin,1, CHARINDEX(' ', margin)-1) as INT)) AS Avg_margin
FROM T20I
WHERE margin LIKE '%RUN%'
GROUP BY winner
ORDER BY Avg_margin DESC

--Q4- Find the average winning margin for each team in match won by wicket in 2024.

SELECT winner,
   AVG(CAST(SUBSTRING(margin,1, CHARINDEX(' ', margin)-1) as INT)) AS Avg_margin_wicket
FROM T20I
WHERE margin LIKE '%wicket%'
GROUP BY winner
ORDER BY Avg_margin_wicket DESC

--Q5- Identify match player between two specific team (eg.- India and South Africa ) in 2024

SELECT*
FROM T20I
WHERE ((Team1 = 'India' AND team2 = 'South Africa') OR
      (Team1 = 'South Africa' AND team2 = 'India'))

--Q6- List all matches where the winning margin was grater than the average margin across all matches.

SELECT*
FROM T20I
WITH AVGmargin AS(
 SELECT AVG(CAST(SUBSTRING(margin, 1 CHARINDEX(' ', MARGIN)-1) AS INT)) AS Avg_overall_margi
 FROM T20I
 WHERE margin LIKE '%run%'
)
SELECT * 
FROM T20I
LEFT JOIN AVGmargin A ON 1=1
WHERE T.Margin LIKE '%RUN%'
AND CAST(SUBSTRING(Margin,1 CHARINDEX(' ', Margin)-1 ))> A.Avg_overall_margin
	  

