sqlcmd -U sa -P "bxcr@dm!Npaas" -S localhost -Q "create login bxcr with password=N'password', default_database=[master], check_expiration=off, check_policy=off"
sqlcmd -U sa -P "bxcr@dm!Npaas" -S localhost -Q "exec master..sp_addsrvrolemember @loginame = N'bxcr', @rolename = N'sysadmin'"
sqlcmd -U sa -P "bxcr@dm!Npaas" -S localhost -Q "EXEC sp_configure 'remote access', 0"
sqlcmd -U sa -P "bxcr@dm!Npaas" -S localhost -Q "RECONFIGURE"