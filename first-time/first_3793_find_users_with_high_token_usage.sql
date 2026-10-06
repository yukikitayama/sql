# Write your MySQL query statement below

with cte as (
    select
        user_id,
        count(*) as count_prompt,
        sum(tokens) / count(*) as avg_token,
        max(tokens) as max_token
    from prompts
    group by 1
)

select
    user_id,
    count_prompt as prompt_count,
    round(avg_token, 2) as avg_tokens
from cte
where count_prompt >= 3
    and max_token > avg_token
order by 3 desc,
    1