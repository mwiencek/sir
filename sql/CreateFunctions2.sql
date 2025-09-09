\set ON_ERROR_STOP 1
BEGIN;

CREATE OR REPLACE FUNCTION sir.a_ins_dbmirror2_pending_data() RETURNS trigger AS $$
BEGIN
    INSERT INTO sir.pending_data
            (seqid, xid, xid_ts, tablename, op, olddata, newdata,
             attempts, last_attempted, failure_reason)
        SELECT seqid, tablename, op, xid, ts, olddata, newdata,
               0, NULL, ''
        FROM inserted_rows
        JOIN dbmirror2.pending_ts ts ON ts.xid = inserted_rows.xid;
    SELECT NULL;
END;
$$ LANGUAGE SQL;

COMMIT;
