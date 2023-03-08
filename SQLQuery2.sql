----What grades are stored in the database?
--SELECT * FROM Grade

----What emotions may be associated with a poem?
--SELECT * FROM Emotion

----How many poems are in the database?
--SELECT COUNT(*) FROM Poem

----Sort authors alphabetically by name. What are the names of the top 76 authors?
--SELECT TOP 76 * FROM Author
--ORDER BY Author.Name

----Starting with the above query, add the grade of each of the authors.
--SELECT TOP 76 * FROM Author
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--ORDER BY Author.Name

----Starting with the above query, add the recorded gender of each of the authors.
--SELECT TOP 76 Author.Name AS Author, Gender.Name as Gender, Grade.Name as Grade FROM Author
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--LEFT JOIN Gender on Author.GenderId = Gender.Id
--ORDER BY Author.Name

----What is the total number of words in all poems in the database?
--SELECT SUM(WordCount) as 'Number of Words' FROM Poem
----Which poem has the fewest characters?
--SELECT TOP 1 * FROM Poem
--ORDER BY CharCount

----How many authors are in the third grade?
--SELECT count(*) AS 'People in Grade' FROM Author
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--WHERE Grade.Name = '2nd Grade'

----How many total authors are in the first through third grades?
--SELECT count(*) AS 'People in Grade' FROM Author
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--WHERE Grade.Name = '1st Grade'
--OR Grade.Name = '2nd Grade'
--OR Grade.Name = '3rd Grade'

----What is the total number of poems written by fourth graders?
--SELECT COUNT(*) as PoemsInGrade FROM Poem
--LEFT JOIN Author ON Author.Id = Poem.AuthorId
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--WHERE Grade.Name = '4th Grade'

----How many poems are there per grade?
--SELECT COUNT(*), Grade.Name as PoemsInGrade FROM Poem
--LEFT JOIN Author ON Author.Id = Poem.AuthorId
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--GROUP BY Grade.Name

----How many authors are in each grade? (Order your results by grade starting with 1st Grade)
--SELECT COUNT(*), Grade.Name AS AuthorsInGrade FROM Author
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--GROUP BY Grade.Name
--ORDER BY Grade.Name

----What is the title of the poem that has the most words?
--SELECT TOP 1 Title, WordCount FROM Poem
--ORDER BY WordCount DESC

----Which author(s) have the most poems? (Remember authors can have the same name.)
--SELECT count(Title) NumPoems, AuthorId, Author.Name FROM Poem
--LEFT JOIN Author ON Poem.AuthorId = Author.Id
--GROUP BY AuthorId, Author.Name
--ORDER BY count(Title) DESC

----How many poems have an emotion of sadness?
--SELECT COUNT(Title) as NumSadPoem FROM Poem
--LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
--LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
--WHERE Emotion.Name = 'Sadness'

--How many poems are not associated with any emotion?
--SELECT COUNT(*) as NumNoEmotionPoem FROM Poem
--LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
--LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
--WHERE PoemEmotion.EmotionId is null

--Which emotion is associated with the least number of poems?
--SELECT COUNT(PoemEmotion.PoemId), Emotion.Name FROM PoemEmotion
--LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
--GROUP BY EmotionId, Emotion.Name
--ORDER BY PoemEmotion.EmotionId 

--Which grade has the largest number of poems with an emotion of joy?
--SELECT COUNT (PoemEmotion.PoemId) AS NumJoyPoems, Emotion.Name, Grade.Name FROM PoemEmotion
--LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
--LEFT JOIN Poem ON PoemEmotion.PoemId = Poem.Id
--LEFT JOIN Author ON Poem.AuthorId = Author.Id
--LEFT JOIN Grade ON Author.GradeId = Grade.Id
--GROUP BY Emotion.Name, Grade.Name
--Having Emotion.Name = 'Joy'
--ORDER BY Grade.Name DESC

--Which gender has the least number of poems with an emotion of fear?
SELECT COUNT(PoemEmotion.PoemId) AS NumJoyPoems, Emotion.Name, Gender.Name FROM PoemEmotion
LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
LEFT JOIN Poem ON PoemEmotion.PoemId = Poem.Id
LEFT JOIN Author ON Poem.AuthorId = Author.Id
LEFT JOIN Grade ON Author.GradeId = Grade.Id
LEFT JOIN Gender On Author.GenderId = Gender.Id
GROUP BY Emotion.Name, Gender.Name
Having Emotion.Name = 'Fear'
ORDER BY COUNT(PoemEmotion.PoemId)
