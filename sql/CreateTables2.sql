\set ON_ERROR_STOP 1
BEGIN;

CREATE SCHEMA IF NOT EXISTS sir;

CREATE TABLE sir.pending_data (
    seqid       	BIGINT NOT NULL,
    xid         	BIGINT NOT NULL,
    xid_ts      	TIMESTAMP WITH TIME ZONE NOT NULL,
    tablename   	TEXT NOT NULL,
    op          	"char" NOT NULL,
    olddata     	JSON,
    newdata     	JSON,
    attempts    	SMALLINT NOT NULL DEFAULT 0,
    last_attempted	TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    failure_reason  TEXT NOT NULL DEFAULT ''
);

ALTER TABLE sir.pending_data
    ADD CONSTRAINT pending_data_pkey
    PRIMARY KEY (seqid, xid);

CREATE TABLE sir.last_indexed (
	entity_type 	TEXT NOT NULL,
	gid 			UUID NOT NULL,
	last_indexed 	TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

ALTER TABLE sir.last_indexed
    ADD CONSTRAINT last_indexed_pkey
    PRIMARY KEY (entity_type, gid);

COMMIT;
