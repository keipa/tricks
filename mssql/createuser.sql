CREATE LOGIN bhf_adebayoa   
    WITH PASSWORD = 'qwaszx@1wesdxc#2';  
GO  
use [bhf-ndd-qa]

CREATE USER bhf_adebayoa FOR LOGIN bhf_adebayoa;  
GO  

EXEC sp_addrolemember N'db_datareader', N'bhf_adebayoa'
GO
