ALTER TABLE customer
ADD count_check SMALLINT;
UPDATE customer
SET count_check = 0;
CREATE OR Replace FUNCTION bonus_return_date() RETURNS trigger AS $$
DECLARE count smallint;
BEGIN
SELECT count_check INTO count
FROM customer
WHERE customer_id = NEW.customer_id;
IF count = 2 THEN 
NEW.return_date := NEW.return_date + interval '7 day';
UPDATE customer
SET count_check = 0
WHERE customer_id = NEW.customer_id;
ELSE
UPDATE customer
SET count_check = count_check + 1
WHERE customer_id = NEW.customer_id;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER check_return_date BEFORE
INSERT ON rental FOR EACH ROW EXECUTE FUNCTION bonus_return_date();