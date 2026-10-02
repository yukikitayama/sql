# Write your MySQL query statement below

/*
*/

with

user_metrics as (
    select
        user_id,
        count(distinct content_id) as count_content
    from reactions
    group by 1
),

reaction_metrics as (
    select
        user_id,
        reaction,
        count(*) as count_reaction
    from reactions
    group by 1, 2
)

select
    u.user_id,
    r.reaction as dominant_reaction,
    round(r.count_reaction / u.count_content, 2) as reaction_ratio
from user_metrics as u
left join reaction_metrics as r
on u.user_id = r.user_id
where
    u.count_content >= 5
    and r.count_reaction / u.count_content >= 0.6
order by 3 desc, 1