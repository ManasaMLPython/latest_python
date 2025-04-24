-- BANKING EXAMPLE

-- STEP1: CREATE TABLES
CREATE TABLE bank_accounts(
	account_id serial primary key,
	holder_name text not null,
	balance numeric(12,2) not null default 0
);
CREATE TABLE bank_transactions (
	tx_id SERIAL PRIMARY KEY,
    account_id INT,
    tx_type TEXT,
    amount NUMERIC(12, 2),
    status TEXT,
    log_time TIMESTAMP DEFAULT now()
);
INSERT INTO bank_transactions(account_id, status) VALUES
(123456, 'ya'),
(7891011, 'no');

SELECT * FROM bank_accounts;

SELECT * FROM bank_transactions;

INSERT INTO bank_accounts(holder_name, balance) VALUES
('Alice', 1000),
('Bob', 500);

--STORED PROCEDURE WITH COMMIT SAVEPOINT AND ROLLBACK
DROP PROCEDURE transfer_funds(integer,integer,numeric) ;
CREATE OR REPLACE PROCEDURE transfer_funds(
    from_account INT,
    to_account INT,
    amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    from_balance NUMERIC;
BEGIN
    -- Start: Save the point
    SAVEPOINT before_transfer;
    -- Check balance
    SELECT balance INTO from_balance FROM bank_accounts WHERE account_id = from_account;
    IF from_balance IS NULL THEN
        RAISE EXCEPTION 'From account does not exist';
    ELSIF from_balance < amount THEN
        RAISE EXCEPTION 'Insufficient funds';
    END IF;
    -- Debit sender
    UPDATE bank_accounts
    SET balance = balance - amount
    WHERE account_id = from_account;
    -- Credit receiver (simulate possible failure with wrong ID)
    UPDATE bank_accounts
    SET balance = balance + amount
    WHERE account_id = to_account;
    -- Log transaction
    INSERT INTO bank_transactions(account_id, tx_type, amount, status)
    VALUES (from_account, 'transfer-out', amount, 'success'),
           (to_account, 'transfer-in', amount, 'success');
    COMMIT;  -- All good
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: , rolling back.';
        ROLLBACK TO SAVEPOINT before_transfer;

        -- Optional: log the failed transaction
        INSERT INTO bank_transactions(account_id, tx_type, amount, status)
        VALUES (from_account, 'transfer-out', amount, 'failed');
        COMMIT;  -- Commit the rollback + failed log
END;
$$;
CALL transfer_funds(1,2,100);

CREATE OR REPLACE PROCEDURE test()
LANGUAGE PLPGSQL
AS $$
BEGIN
	SELECT * FROM bank_accounts;
	SELECT * FROM transfer_funds;
END;
$$;
CALL test();

CREATE OR REPLACE FUNCTION test_combined()
RETURNS TABLE(info TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 'Account ID: ' || account_id || ', Balance: ' || balance
    FROM bank_accounts;

    RETURN QUERY
    SELECT 'account id: ' || account_id || ' -> ' || status 
    FROM bank_transactions;
END;
$$;
SELECT * FROM test_combined();
