Backup:  

`$ pg_dump -U {user-name} {source_db} -f {dumpfilename.sql}`

Restore: 

`$ psql -U {user-name} -d {desintation_db}-f {dumpfilename.sql}`