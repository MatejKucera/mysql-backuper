# MySQL Backuper

This docker app is used for regular MySQL backups.

## Requirements
- git
- docker (including compose plugin)

## Installation
1. Clone the repository
2. Rename ``.env.example`` => ``.env``
3. Rename ``config.json.example`` => ``config.json``
4. Configure ``.env`` and ``config.json`` files
5. Start the container using ``docker compose up``

## Configuration

### Limitations
- Schedule, compression level and retention can't be set per database and is same for all database.
- Backup processes are run in series, not in parallel. If the first process takes too long, the execution of the next process is delayed until the first one finishes.

### ``.env``
In ``.env``, set paths to output directory and config file, compression level (fastest/lowest: 1, slowest/largest: 9), backup retention in days and schedule in cron syntax. 

```bash
# Docker compose project name
COMPOSE_PROJECT_NAME=mysqlbackuper

# Path to the configuration file
PATH_CONFIG_FILE=__SET_PATH_TO_config.json__

# Path to the output directory
PATH_OUTPUT_DIR=__SET_DIRECTORY__

# Compression level, min 1, max 9
COMPRESSION_LEVEL=9

# For how many days is the backup stored
BACKUP_RETENTION_DAYS=180

# Backup schedule, cron syntax
SCHEDULE="* * * * *"
```

### ``config.json``

In ``config.json``, define connections to all databases that are supposed to be backed up:
```json
[
    {
        "hostname": "146.102.42.42",
        "port":     "3306",
        "database": "network",
        "username": "user",
        "password": "secret"
    },
    {
        "hostname": "146.102.42.42",
        "port":     "3306",
        "database": "netreg",
        "username": "user",
        "password": "secret"
    }
]
```