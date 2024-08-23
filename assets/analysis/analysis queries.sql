use youtube_db;

/*

1. Define The variables
2. Create CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the youtube channels with the highest subscriber bases
5. Order by net profit (from highest to lowest)

*/

-- 1
declare @ConversionRate float = 0.02;
declare @ProductCost money = 5.0;
declare @CampaignCost money = 50000.0;


-- 2 
with ChannelData as(
select channel_name,
total_views,
total_videos,
ROUND(CAST(total_views AS FLOAT) / total_videos, -4) AS avg_views_per_video
from uk_youtubers
)


-- 3

select channel_name,
avg_views_per_video,
avg_views_per_video * @ConversionRate as potential_units_sold_per_video,
(avg_views_per_video * @ConversionRate) * @ProductCost as potential_revenue_per_video,
(avg_views_per_video * @ConversionRate ) *  @ProductCost - @CampaignCost as net_profit 
from ChannelData

-- 4
where channel_name in ('NoCopyrightSounds','DanTDM','Dan Rhodes')

-- 5 
order by net_profit desc

;