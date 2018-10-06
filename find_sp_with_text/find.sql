DECLARE @searchString VARCHAR(MAX)
SET @searchString = 'SEARCHTERM'
SELECT
  name,
  (LEN(Object_definition(object_id)) - LEN(REPLACE(Object_definition(object_id), @searchString, ''))) /
  LEN(@searchString)                AS [Occ],
  len(Object_definition(object_id)) AS [Len]
FROM sys.procedures -- objects
WHERE Object_definition(object_id) LIKE '%' + @searchString + '%'
ORDER BY [Occ] DESC, [Len] DESC


--

SELECT name
FROM   sys.procedures -- objects
WHERE  Object_definition(object_id) LIKE '%SEARCHTERM%' ORDER BY len(Object_definition(object_id)) DESC



-- search by column names
SELECT c.name AS ColName, t.name AS TableName
FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
WHERE c.name LIKE '%postalcode%'
