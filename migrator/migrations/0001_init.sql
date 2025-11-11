-- raw layer
CREATE TABLE IF NOT EXISTS raw_prices (
    id BIGSERIAL PRIMARY KEY,
    asset TEXT NOT NULL,
    price NUMERIC(18,8) NOT NULL,
    volume NUMERIC(18,8) NOT NULL,
    market_cap NUMERIC(18,2),
    ts TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- aggregation layer
CREATE TABLE IF NOT EXISTS agg_prices (
    bucket_start TIMESTAMP WITH TIME ZONE NOT NULL,
    bucket_end TIMESTAMP WITH TIME ZONE NOT NULL,
    asset TEXT NOT NULL,
    price_open NUMERIC(18,8),
    price_close NUMERIC(18,8),
    price_high NUMERIC(18,8),
    price_low NUMERIC(18,8),
    price_avg NUMERIC(18,8),
    volume_total NUMERIC(18,8),
    volatility NUMERIC(18,8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (bucket_start, asset)
);

-- views placeholder
CREATE OR REPLACE VIEW vw_latest_agg AS
SELECT *
FROM agg_prices
ORDER BY bucket_end DESC
LIMIT 100;


