SELECT name
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%search text%'

--or

SELECT name
FROM   sys.objects
WHERE  Object_definition(object_id) LIKE '%search text%'

-- search by column names
SELECT c.name AS ColName, t.name AS TableName
FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
WHERE c.name LIKE '%postalcode%'
