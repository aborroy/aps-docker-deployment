ALTER SYSTEM SET max_connections = 500;
ALTER SYSTEM RESET shared_buffers;

CREATE DATABASE activitiadmin;
GRANT ALL PRIVILEGES ON DATABASE activitiadmin TO alfresco;
