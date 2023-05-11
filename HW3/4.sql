ALTER TABLE film
ADD CHECK (length >= 50) NOT VALID;
ALTER TABLE payment
ADD pay_type VARCHAR(11) CHECK (pay_type in ('credit_card', 'cash', 'online'));