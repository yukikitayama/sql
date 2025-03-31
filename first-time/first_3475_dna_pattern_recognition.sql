# Write your MySQL query statement below
SELECT
    sample_id,
    dna_sequence,
    species,
    CASE WHEN dna_sequence REGEXP '^ATG' THEN 1 ELSE 0 END AS has_start,
    CASE WHEN dna_sequence REGEXP 'TAA$|TAG$|TGA$' THEN 1 ELSE 0 END AS has_stop,
    CASE WHEN dna_sequence REGEXP 'ATAT' THEN 1 ELSE 0 END AS has_atat,
    CASE WHEN dna_sequence REGEXP 'G{3,}' THEN 1 ELSE 0 END AS has_ggg
FROM
    Samples
;