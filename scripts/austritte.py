#!/usr/bin/python3
import psycopg2
import argparse

def gen_delete_member(dbname, infile):
    sql = "SELECT id FROM member WHERE invite_code IN ("

    with open(infile, "r") as fobj:
        for line in fobj:
            if line != "":
                sql = sql + "\n  '" + line.replace("\n", "") + "',"

    sql = sql[:-1] + "\n);"

    psqlcon = "host='' dbname='" + dbname + "'"

    conn = psycopg2.connect(psqlcon)

    cursor = conn.cursor()
    cursor.execute(sql)

    print("BEGIN;")

    for row in cursor:
        print("SELECT delete_member({});".format(row[0]))

    print("COMMIT;")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('db', nargs='?', default='liquid_feedback_lsa', help='Name der LQFB Datenbank')
    parser.add_argument('-i', '--infile', nargs='?', default='austritte.txt', help='Name der Datei mit den Invitecodes (ein Code pro Zeile)')
    args = parser.parse_args()
    gen_delete_member(args.db, args.infile)
