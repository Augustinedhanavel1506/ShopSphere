ALTER TABLE users
    ADD COLUMN email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN verification_token VARCHAR(100) NULL,
    ADD COLUMN verification_token_expiry TIMESTAMP NULL,
    ADD COLUMN reset_token VARCHAR(100) NULL,
    ADD COLUMN reset_token_expiry TIMESTAMP NULL;

UPDATE users SET email_verified = TRUE;
