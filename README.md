# xtrabackup

This image contains xtrabackup and provides a nice way to run xtrabackup against dockerized MySQL installs. This version does not support MariaDB.

## Usage

This image must be able to talk directly to the volume holding the MySQL data files as well as MySQL itself when performing backups. For restores it is only necessary that the MySQL container be stopped and this image have access to the data volume.

### Performing a backup

Here is an example of creating a backup for wp-local-docker. With MySQL running, issue:

```
docker run \
  --rm \
  --name xtrabackup \
  --network wplocaldocker \
  -ti \
  --volumes-from global_mysql_1 \
  -v $(pwd)/backup:/backup \
  dustinrue/xtrabackup --backup --host=mysql --user=root --password=password --target-dir=/backup
```

This will copy out the data files into a local directory of `backup`

### Performing a restore

Another example for use with wp-local-docker. Stop the target MySQL container and issue the following commands:

First, delete the old data volume

`docker volume rm global_mysqlData`

Next, restore the data

```
docker run --rm \
  --name xtrabackup \
  -ti \
  -v global_mysqlData:/var/lib/mysql \
  -v $(pwd)/backup:/backup \
  dustinrue/xtrabackup --copy-back --target-dir=/backup --datadir=/var/lib/mysql
```
