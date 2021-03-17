do_data <- function(data){
new = data[data$noun_requires_determiner=='yes',c('user_name','variant','final_age','latitude','longitude','modifier_status','nearest_area')]
new <- na.omit(new)
new %<>% group_by(user_name) %>% mutate(age = mean(final_age)) %>% ungroup()
new$final_age <- new$age
new %<>% group_by(user_name,final_age,variant,modifier_status,nearest_area) %>% summarise(variant_count = n())
new %<>% group_by(user_name) %>% mutate(n = sum(variant_count)) %>% ungroup()
new$score <- new$variant_count/new$n
bad <- new[(new$variant =='preposition_retained')&(new$score==1),]
bad$score <- 0
bad$variant <- 'preposition_dropped'
new <- rbind(new,bad)
bad$variant <- 'preposition_dropped_with_determiner'
new <- rbind(new,bad)
new %<>% group_by(final_age,variant,modifier_status,nearest_area) %>% summarise(final = n(),score = mean(score))
return(new)
}


m <- glm(score ~ birthyear + nearest_area, family = binomial, data = subset(new,modifier_status=='modifier_absent' & new$variant=='preposition_dropped'))


plot_df <- augment(m, type.predict = "response")
ggplot(subset(new,modifier_status=='modifier_absent' & new$variant=='preposition_dropped'),aes(x=birthyear,y=score,color=nearest_area))+lims(x=c(1930,2010),y=c(0,0.3))+ stat_summary_bin(geom = "point", fun = mean, aes(y = score))+geom_line(data=plot_df,aes(y=.fitted))+theme_bw()+theme(text=element_text(family="Lato"))+xlab('estimated birthyear')+ylab('mean rate of preposition drop')+labs(size='number of users',color='nearest city')

do_data <- function(data){
new = data[data$noun_requires_determiner=='yes',c('user_name','variant','age_category','latitude','longitude','modifier_status')]
new <- na.omit(new)
new$age_category <- factor(new$age_category,c("< 30","30–60","> 60"))
new %<>% group_by(user_name,age_category,variant,modifier_status) %>% summarise(variant_count = n())
new %<>% group_by(user_name) %>% mutate(n = sum(variant_count)) %>% ungroup()
new$score <- new$variant_count/new$n
bad <- new[(new$variant =='preposition_retained')&(new$score==1),]
bad$score <- 0
bad$variant <- 'preposition_dropped'
new <- rbind(new,bad)
bad$variant <- 'preposition_dropped_with_determiner'
new <- rbind(new,bad)
return(new)}
new %<>% group_by(final_age,variant,modifier_status) %>% summarise(final = n(),score = mean(score))
return(new)}








ggplot(new,aes(x=2019-final_age,y=score,size=final,color=variant))+geom_point()+geom_smooth(size=0.2,alpha=0.1)+theme_bw()+theme(text=element_text(family="Lato"))+lims(x=c(1940,2007),y=c(0,1))+xlab('estimated birthyear')+ylab('mean rate of preposition drop')+labs(size='number of users',color='modifier?')+facet_wrap(~modifier_status)