# Write your MySQL query statement below


with recursive cte as (
    select
        content_id,
        content_text,
        -- First word
        1 as pos,
        -- Current word
        substring_index(content_text, ' ', 1) as word,
        -- Remainng words
        substring(
            content_text,
            -- Start position, length() + 2 is the current word and after one space
            length(substring_index(content_text, ' ', 1)) + 2
        ) as remaining
    from user_content

    union all

    select
        content_id,
        content_text,
        -- Next word
        pos + 1,
        -- Next current word
        substring_index(remaining, ' ', 1) as word,
        -- Next remaining words
        substring(
            remaining,
            length(substring_index(remaining, ' ', 1)) + 2
        ) as remaining
    from cte
    where remaining != ''
)

-- select * from cte

select
    content_id,
    content_text as original_text,
    group_concat(
        concat(
            -- Only first letter upper case
            upper(left(word, 1)),
            -- From the second characters lower case
            lower(substring(word, 2))
        )
        order by pos
        separator ' '
    ) as converted_text
from cte
group by 1
order by 1

