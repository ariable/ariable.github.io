BACKUPDATE=$(date +%Y%m%d)
ZIPFILE="${BACKUPDATE}".zip
ENC_ZIPFILE="${BACKUPDATE}".enc
mysqldump -u user -p pass db1 > db1.sql
mysqldump -u user -p pass db2 > db2.sql
zip -rq "${ZIPFILE}" /files_need_to_backup
openssl enc -aes-256-cfb -a -salt -pass file:pass.txt -in "${ZIPFILE}" -out "${ENC_ZIPFILE}"
sleep 1s
rclone copy "${ENC_ZIPFILE}" remote:
rm "${ZIPFILE}" "${ENC_ZIPFILE}" *.sql