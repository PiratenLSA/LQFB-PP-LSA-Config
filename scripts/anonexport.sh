#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 <dbname>"
  exit 1
fi

EXPORT_DBNAME=liquid_feedback_autoexport
EXPORT_TIME=`date +"%F_%H-%M"`
EXPORT_FILE=/opt/anondumps/anondump_${EXPORT_TIME}.sql.xz
retval=0

echo "Dropping database \"$EXPORT_DBNAME\" if existent..."
dropdb "$EXPORT_DBNAME" 2> /dev/null
echo "Copying database \"$1\" to new database \"$EXPORT_DBNAME\"..."
# TODO: use character encoding of original database
if (createdb "$EXPORT_DBNAME" && pg_dump "$1" | psql -f - "$EXPORT_DBNAME" > /dev/null)
then
  echo "Deleting private data in copied database..."
  if psql -v ON_ERROR_STOP=1 -c 'SELECT delete_private_data()' "$EXPORT_DBNAME" > /dev/null
  then
    echo "Dumping and compressing copied database to \"$2\"..."
    if pg_dump --no-owner --no-privileges "$EXPORT_DBNAME" | xz > "${EXPORT_FILE}"
    then
      true
    else
      retval=4
    fi
  else
    retval=3
  fi
else
  retval=2
fi
echo "Dropping database \"$EXPORT_DBNAME\"..."
dropdb "$EXPORT_DBNAME"
echo "DONE."
exit $retval
