SELECT name
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%search text%'

--or

SELECT name
FROM   sys.objects
WHERE  Object_definition(object_id) LIKE '%search text%'
