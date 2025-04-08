# Write your MySQL query statement below
WITH RECURSIVE

chains AS (
    SELECT
        giver_id,
        receiver_id,
        1 AS chain_length,
        gift_value
    FROM
        SecretSanta
    UNION ALL
    SELECT
        a.giver_id,
        b.receiver_id,
        a.chain_length + 1,
        a.gift_value + b.gift_value
    FROM
        chains AS a
    INNER JOIN
        SecretSanta AS b
    ON
        a.giver_id != a.receiver_id
        AND a.receiver_id = b.giver_id
),

distinct_chains AS (
    SELECT
        -- Every ID can be start and end, so get distinct length of sequences
        DISTINCT chain_length,
        gift_value AS total_gift_value
    FROM
        chains
    WHERE
        giver_id = receiver_id
)

-- SELECT * FROM chain

SELECT
    RANK() OVER(ORDER BY chain_length DESC, total_gift_value DESC) AS chain_id,
    chain_length,
    total_gift_value
FROM
    distinct_chains
ORDER BY
    1
;