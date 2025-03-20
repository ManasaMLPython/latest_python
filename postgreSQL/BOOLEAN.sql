-- BOOLEAN data types
-- TRUE('true','t','yes','y','1'/FALSE,'false','f','no','n','0'/NULL

CREATE TABLE public.table_boolean
(
    product_id serial,
    is_available boolean NOT NULL,
    PRIMARY KEY (product_id)
);

INSERT INTO table_boolean(is_available)
VALUES (TRUE),
	(TRUE),
	(FALSE),
	(FALSE),
	(TRUE);

SELECT * FROM table_boolean;

ALTER TABLE table_boolean
ALTER COLUMN is_available
SET DEFAULT FALSE

INSERT INTO table_boolean(product_id)
VALUES (99)
RETURNING *