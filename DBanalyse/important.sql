--use database


SELECT TOP 50 name
FROM sys.procedures
ORDER BY len(Object_definition(object_id)) DESC
