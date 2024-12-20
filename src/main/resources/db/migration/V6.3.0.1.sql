
ALTER TABLE datasetversion ADD COLUMN IF NOT EXISTS modifieddate_id BIGINT;
ALTER TABLE datasetversion DROP CONSTRAINT IF EXISTS fk_datasetversion_datasetversionmodifieddate;
ALTER TABLE datasetversion ADD CONSTRAINT fk_datasetversion_datasetversionmodifieddate FOREIGN KEY (modifieddate_id) REFERENCES datasetversionmodifieddate (id);
-- TODO: should existing values be copied to the new table?
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='datasetversion' AND column_name='lastupdatetime') THEN
        ALTER TABLE datasetversion ALTER COLUMN lastupdatetime DROP NOT NULL;
    END IF;
END $$;
