#!/bin/sh

# DB host (secondary preferred as to avoid impacting primary performance)
HOST=172.31.41.217:27017

# DB name
DBNAME=edxapp
USERNAME=JGiMdhCEcTBsG6qla5lB2
PASSWORD=GbutCL4Fg3gQW0sSOBk0
# S3 bucket name
BUCKET=openedxuex-mongo-backups

# Linux user account
USER=ubuntu

# Current time
TIME=`/bin/date +%d-%m-%Y-%T`

# Backup directory
DEST=/home/$USER/tmp

# Tar file of backup directory
TAR=$DEST/../$TIME.tar
S3PATH="s3://openedxuex-mongo-backups/"
S3BACKUP=$S3PATH`/bin/date +"%d-%m-%Y-%T"`.dump.gz


# Create backup dir (-p to avoid warning if already exists)
#/bin/mkdir -p $DEST

# Log
echo "Backing up $HOST/$DBNAME to s3://$BUCKET/ on $TIME";

# Dump from mongodb host into backup directory
#/usr/bin/mongodump -h $HOST -d $DBNAME  -o $DEST | gzip -9 -f
/usr/bin/mongodump -h $HOST -d $DBNAME --archive | gzip -9 | aws s3 cp - $S3BACKUP

# Create tar of backup directory
#/bin/tar cvf $TAR -C $DEST .

# Upload tar to s3
#/usr/bin/aws s3 cp $TAR s3://$BUCKET/

# Remove tar file locally
#/bin/rm -f $TAR

# Remove backup directory
#/bin/rm -rf $DEST

# All done
echo "Backup available at https://s3.amazonaws.com/$BUCKET/$TIME.tar"
