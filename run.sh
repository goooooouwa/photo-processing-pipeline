#!/bin/bash

## 1. Categorize photos by date with PhotoMove 2.5
### PhotoMove 2.5 Download link: https://photomove.software.informer.com/2.5/
### Folder strcuture example: /2022/2022_08/2022_08_04/IMG.jpg
# Open PhotoMove -> Move to Destination Folders

## 2. rename categorized photo filenames based on exif info
exiftool '-filename<CreateDate' -d %Y-%m-%d_%H%M%S%%-c.%%le -r /path/to/src/folder/

## 2. Flat uncategorized photos into one folder
### Ref: https://nicolasbouliane.com/blog/flatten-directory-linux-macos
find /path/to/src/folder/ -mindepth 2 -type f -exec mv -i '{}' /path/to/dest/folder/ ';'

## 3. Clean up .AAE files
### Ref: https://superuser.com/questions/112078/delete-matching-files-in-all-subdirectories
find /path/to/folder/ -name \*.AAE -type f -delete

## 4. Move photos to media drive
mv /path/to/src/folder/ /path/to/dest/folder/

## 5. Back up with Restic
### Ref: https://restic.readthedocs.io/en/stable/040_backup.html
restic -r /srv/restic-repo --verbose backup /path/to/photos/folder/
