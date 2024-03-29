# MySQL Backuper

This docker app is used for regular MySQL backups.

## Requirements
- git
- docker (including compose plugin)

## Installation
 1. Clone the repository
```bash
git clone https://github.com/MatejKucera/mysql-backuper/
cd mysql-backuper
```
2. Rename ``.env.example`` => ``.env``
```bash
mv .env.example .env
```
3. Rename ``config.example.json`` => ``config.json``
```bash
mv config.example.json config.json
```
4. Configure ``.env`` and ``config.json`` files, see Configuration below.
5. Start the container using ``docker compose up``
```bash
docker compose up
```
to run in a background (detached terminal) add ``-d``
```bash
docker compose up -d
```

## Configuration

### Limitations
- Schedule, compression level and retention can't be set uniquely per database and are same for all databases.
- Backup processes are run in series, not in parallel. If the first process takes too long, the execution of the next process is delayed until the first one finishes.

### ``.env``
In ``.env``, set paths to output directory and config file, compression level, backup retention in days and schedule in cron syntax. 

Compression level 1 is the fastest and lowest compression setting. Level 9 is the slowest and best compression.

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

In ``config.json``, define connections to all databases that are supposed to be backed up.

The amount of connections it not limited.
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