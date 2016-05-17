Select Top 100 RecommendationScore, Code
	from DesignTemplateView
	where RecommendationScore > 1 and Code != 'DESIGNWITHMACOT'
	order by RecommendationScore desc