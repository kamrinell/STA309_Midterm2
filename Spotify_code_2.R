####library
library(tidyverse)
library(tidytext)
library(ggwordcloud)
library(ggrepel)
library(patchwork)
word_sentiments <- get_sentiments("bing")

#### Lyrics ####
## downloaded as is
thefame_lyrics <- scan("https://github.com/kamrinell/STA309_Midterm2/blob/main/Spotify_Lyrics/TheFame.txt",
                       what=character(),
                       blank.lines.skip=FALSE, sep="\n")
artpop_lyrics <- scan("https://github.com/kamrinell/STA309_Midterm2/blob/main/Spotify_Lyrics/Artpop.txt",
                      what=character(),
                      blank.lines.skip=FALSE, sep="\n")
mayhem_lyrics <- scan("https://github.com/kamrinell/STA309_Midterm2/blob/main/Spotify_Lyrics/Mayhem.txt",
                      what=character(),
                      blank.lines.skip=FALSE, sep="\n")
# tidy to data frame
#### Album The Fame ####
tidy_fame <- thefame_lyrics%>%            ## tidy for word clouds and sentiment analysis
  data.frame(text=thefame_lyrics)%>%
  mutate(Album = "The Fame")%>%
  unnest_tokens(output= word, input= text)

fame_pop <- tidy_fame%>%
  group_by(word)%>%
  summarize(N=n()) %>%
  inner_join(word_sentiments)%>%
  slice_max(N, n=20)

#### Plot 1 ####
cloud_fame <- ggplot(fame_pop)+
  geom_text_wordcloud(aes(label=word, size=N, color=sentiment))+
  scale_size_area(max_size=25)+
  labs(title = "The Fame")+
  theme_minimal()

#### Album ARTPOP ####
tidy_artpop <- artpop_lyrics%>%            ## tidy for word clouds and sentiment analysis
  data.frame(text=artpop_lyrics)%>%
  mutate(Album = "ARTPOP")%>%
  unnest_tokens(output= word, input= text)

artpop_pop <- tidy_artpop%>%
  group_by(word)%>%
  summarize(N=n()) %>%
  inner_join(word_sentiments)%>%
  slice_max(N, n=20)

#### Plot 2 ####
cloud_artpop <- ggplot(artpop_pop)+
  geom_text_wordcloud(aes(label=word, size=N, color=sentiment))+
  scale_size_area(max_size=25)+
  labs(title = "ARTPOP")+
  theme_minimal()

#### Album Mayhem ####
tidy_mayhem <- mayhem_lyrics%>%            ## tidy for word clouds and sentiment analysis
  data.frame(text=mayhem_lyrics)%>%
  mutate(Album = "Mayhem")%>%
  unnest_tokens(output= word, input= text)

mayhem_pop <- tidy_mayhem%>%
  group_by(word)%>%
  summarize(N=n()) %>%
  inner_join(word_sentiments)%>%
  slice_max(N, n=20)

#### Plot 3 ####
cloud_mayhem <- ggplot(mayhem_pop)+
  geom_text_wordcloud(aes(label=word, size=N, color=sentiment))+
  scale_size_area(max_size=25)+
  labs(title = "Mayhem")+
  theme_minimal()

#### Sentiment analysis of Albums ####
ladygaga_sentiment <- bind_rows(tidy_fame,tidy_artpop,tidy_mayhem)%>%
  inner_join(word_sentiments, by="word")

#### Plot 4 ####
#### need to add annotations and fix where the albums show up and title and axis labels####
album_senti_plot <- ggplot(ladygaga_sentiment)+
  geom_bar(aes(x=Album, fill=sentiment), position="fill")+
  scale_x_discrete(limits=c("The Fame","ARTPOP","Mayhem"))+
  coord_cartesian(expand = FALSE)+
  labs(title="Album Lyric Sentiment",
       y=element_blank())+
  annotate("label",x=2,y=.85,label="Negative\nSentiment")+
  annotate("label",x=2,y=.25,label="Positive\nSentiment")+
  theme_minimal()+
  theme(legend.position = "none")

#### Spotify data ####
#### library
library(spotifyr)
#### access Spotify API with access token
SPOTIFY_CLIENT_ID <- '417f59f74d2a4125a3f02b3dfd58d35d'
SPOTIFY_CLIENT_SECRET <- '4cab3b3b203045d2a7ee997050a8bf87'
access_token <- get_spotify_access_token(SPOTIFY_CLIENT_ID,SPOTIFY_CLIENT_SECRET)

#### Song Popularity from The Fame ####

#file_names <- c("Just_Dance", "Love_Game", "Paparazzi",
#               "Poker_Face","Eh_Eh","Beautiful_Dirty_Rich",
#              "The_Fame","Money_Honey","Starstruck",
#             "BoysBoysBoys","Paper_Gangsta","Brown_Eyes",
#            "I_like_it_rough","Summerboy","Disco_Heaven")

# Base raw URL of the GitHub folder
base_url <- "https://github.com/kamrinell/STA309_Midterm2/blob/main/Spotify_Lyrics/The_Fame/"
dance <- scan(paste0(base_url,"Just_Dance"), what=character(), blank.lines.skip=FALSE, sep="\n" )
dance <- data.frame(text=dance)%>%mutate(Song = "Just Dance")%>%unnest_tokens(output= word, input= text)

game <- scan(paste0(base_url,"Love_Game"), what=character(), blank.lines.skip=FALSE, sep="\n" )
game <- data.frame(text=game)%>%mutate(Song = "LoveGame")%>%unnest_tokens(output= word, input= text)

pap <- scan(paste0(base_url,"Paparazzi"), what=character(), blank.lines.skip=FALSE, sep="\n" )
pap <- data.frame(text=pap)%>%mutate(Song = "Paparazzi")%>%unnest_tokens(output= word, input= text)
###
face <- scan(paste0(base_url,"Poker_Face"), what=character(), blank.lines.skip=FALSE, sep="\n" )
face <- data.frame(text=face)%>%mutate(Song = "Poker Face")%>%unnest_tokens(output= word, input= text)

eh <- scan(paste0(base_url,"Eh_Eh"), what=character(), blank.lines.skip=FALSE, sep="\n" )
eh <- data.frame(text=eh)%>%mutate(Song = "Eh, Eh (Nothing Else I Can Say)")%>%unnest_tokens(output= word, input= text)

beaut <- scan(paste0(base_url,"Beautiful_Dirty_Rich"), what=character(), blank.lines.skip=FALSE, sep="\n" )
beaut <- data.frame(text=beaut)%>%mutate(Song = "Beautiful, Dirty, Rich")%>%unnest_tokens(output= word, input= text)
###
fame <- scan(paste0(base_url,"The_Fame"), what=character(), blank.lines.skip=FALSE, sep="\n" )
fame <- data.frame(text=fame)%>%mutate(Song = "The Fame")%>%unnest_tokens(output= word, input= text)

mon <- scan(paste0(base_url,"Money_Honey"), what=character(), blank.lines.skip=FALSE, sep="\n" )
mon <- data.frame(text=mon)%>%mutate(Song = "Money Honey")%>%unnest_tokens(output= word, input= text)

star <- scan(paste0(base_url,"Starstruck"), what=character(),blank.lines.skip=FALSE, sep="\n" )
star <- data.frame(text=star)%>%mutate(Song = "Starstruck")%>%unnest_tokens(output= word, input= text)
###        
boy <- scan(paste0(base_url,"BoysBoysBoys"),what=character(),blank.lines.skip=FALSE, sep="\n" )
boy <- data.frame(text=boy)%>%mutate(Song = "Boys Boys Boys")%>%unnest_tokens(output= word, input= text)

paper <- scan(paste0(base_url,"Paper_Gangsta"),what=character(),blank.lines.skip=FALSE, sep="\n" )
paper <- data.frame(text=paper)%>%mutate(Song = "Paper Gangsta")%>%unnest_tokens(output= word, input= text)

brown <- scan(paste0(base_url,"Brown_Eyes"), what=character(), blank.lines.skip=FALSE, sep="\n" )
brown <- data.frame(text=brown)%>%mutate(Song = "Brown_Eyes")%>%unnest_tokens(output= word, input= text)
###        
rou <- scan(paste0(base_url,"I_like_it_rough"),what=character(),blank.lines.skip=FALSE, sep="\n" )
rou <- data.frame(text=rou)%>%mutate(Song = "I Like It Rough")%>%unnest_tokens(output= word, input= text)

sum <- scan(paste0(base_url,"Summerboy"),what=character(),blank.lines.skip=FALSE, sep="\n" )
sum <- data.frame(text=sum)%>%mutate(Song = "Summerboy")%>%unnest_tokens(output= word, input= text)

disco <- scan(paste0(base_url,"Disco_Heaven"), what=character(), blank.lines.skip=FALSE, sep="\n" )
disco <- data.frame(text=disco)%>%mutate(Song = "Disco Heaven")%>%unnest_tokens(output= word, input= text)

#### Combined songs ####
songs_senti <- bind_rows(dance,game,pap, face,eh,beaut,fame,mon,star,boy,paper,brown,rou,sum,disco)%>%
  inner_join(word_sentiments, by="word")
song_prop<- songs_senti %>% 
  group_by(Song, sentiment) %>% 
  summarise(cnt = n()) %>% 
  mutate(props = round(cnt / sum(cnt), 2))%>%
  filter(sentiment=="positive")

just_dance <- get_track("2x7MyWybabEz6Y6wvHuwGE", authorization = access_token)
lovegame <- get_track("0TcJ7QWpggdSg8t0fHThHm", authorization = access_token)
pap <- get_track("7Hqig8kp32q2Ire3ECQvWM", authorization = access_token)
poker <- get_track("5R8dQOPq8haW94K7mgERlO", authorization = access_token)
ef <- get_track("4CIu6ip0JlQeCqLLfoqlDW", authorization = access_token)
beaut <- get_track("3qrQtMmkuV79LMGfsGDHRf", authorization = access_token)
fame_song <- get_track("25pWYL5848CIMh3OfnDroM", authorization = access_token)
money <- get_track("5ww65ORP2faNi9ygUjxwId", authorization = access_token)
star <- get_track("2DLsZCx5UEqVB3vY3kZWWB", authorization = access_token)
boys <- get_track("129NQr4tA6j60b59rflcTY", authorization = access_token)
paper <- get_track("0LtZYj18X8mpZ2M6A7nA8t", authorization = access_token)
brown <- get_track("6YSrwzBdLvN5RtzYmWsUPx", authorization = access_token)
rough <- get_track("2FABVB96EnV25oBToWNUk4", authorization = access_token)
summer <- get_track("1c31md8UrbHONSycrFi3Jy", authorization = access_token)
disco <- get_track("20rDqWMo6aYgeTXsX8l2rn", authorization = access_token)

song_pop <- c(just_dance$popularity,lovegame$popularity,
              poker$popularity,ef$popularity,
              fame_song$popularity,
              boys$popularity,paper$popularity,
              rough$popularity,summer$popularity)
Song <- c(just_dance$name,lovegame$name,
          poker$name,ef$name,
          fame_song$name,money$name,
          boys$name,
          rough$name,summer$name)
ap <- data.frame(song_pop, Song)

lg_popsent <- merge(ap,song_prop, by="Song")

#### Plot 5 ####
song_popsenti_plot <- ggplot(data=lg_popsent,aes(x=props,y=song_pop))+
  geom_point()+
  geom_text_repel(aes(label=Song,hjust=-.2), size=5)+
  coord_cartesian(xlim=c(0,1),ylim=c(40,90))+
  annotate("label",x=.15,y=80,label="No seen relation\nbetween sentiment\nand popularity")+
  labs(title="Song's Popularity by Sentiment of Lyrics",
       subtitle="Songs from: The Fame Album",
       x="Proportion of Positive Sentiment in Lyrics",
       y="Popularity")+
  theme_minimal()

#### Additional Plot ####
# Additional Plot using time between albums and popularity for lady gaga
the_fame <- get_album("1jpUMnKpRlng1OJN7LJauV", authorization = access_token)
artpop <- get_album("2eRJUtI7nXrQ5uYQ7tzTo9", authorization = access_token)
mayhem <- get_album("2MHUaRi9OCyTN02SoyRRBJ", authorization = access_token)
the_fame_deluxe <- get_album("6rePArBMb5nLWEaY9aQqL4", authorization = access_token)
born_this_way <- get_album("2KkMVsxymoNR7hRmBcMttd", authorization = access_token)
born_this_way_deluxe <- get_album("5maeycU97NHBgwRr2h2A4O", authorization = access_token)
cheek_to_cheek <- get_album("56uP6C9dDe31eLwhpfgIWT", authorization = access_token)
cheek_to_cheek_deluxe <- get_album("2VX9rp6NAC19TQN4IgkmYu", authorization = access_token)
joanne_deluxe <- get_album("2ZUwFxlWo0gwTsvZ6L4Meh", authorization = access_token)
chromatica <- get_album("05c49JgPmL4Uz2ZeqRx5SP", authorization = access_token)
born_this_way10 <- get_album("6Yf9kML4wT3opmXhTUIfk7", authorization = access_token) 
dawn_of_chromatica <- get_album("3OevODyllQCrhudfLLnV3y", authorization = access_token)
love_for_sale_deluxe <- get_album("6hBQkPnq5u1BwZncSEDEgs", authorization = access_token)

all_popularity <- c(the_fame$popularity,the_fame_deluxe$popularity, born_this_way$popularity,
                    born_this_way_deluxe$popularity,artpop$popularity,cheek_to_cheek$popularity,
                    cheek_to_cheek_deluxe$popularity,joanne_deluxe$popularity,chromatica$popularity,
                    born_this_way10$popularity,dawn_of_chromatica$popularity,love_for_sale_deluxe$popularity)
all_name <- c(the_fame$name,the_fame_deluxe$name, born_this_way$name,
              born_this_way_deluxe$name,artpop$name,cheek_to_cheek$name,
              cheek_to_cheek_deluxe$name,joanne_deluxe$name,chromatica$name,
              born_this_way10$name,dawn_of_chromatica$name,love_for_sale_deluxe$name)
all_date <- c(the_fame$release_date,the_fame_deluxe$release_date, born_this_way$release_date,
              born_this_way_deluxe$release_date,artpop$release_date,cheek_to_cheek$release_date,
              cheek_to_cheek_deluxe$release_date,joanne_deluxe$release_date,chromatica$release_date,
              born_this_way10$release_date,dawn_of_chromatica$release_date,
              love_for_sale_deluxe$release_date)
df <- data.frame(all_popularity,all_name,all_date)

may_pop <- mayhem$popularity
may_name <- mayhem$name
may_date <- mayhem$release_date
df2 <- data.frame(may_pop,may_name,may_date)

#### Plot 6 ####
album_date_plot <- ggplot(data=df, aes(x=ymd(all_date),y=all_popularity))+
  geom_point()+
  geom_text_repel(aes(label=all_name,hjust=-.1), size=4)+
  
  geom_point(data=df2, aes(x=ymd(may_date),y=may_pop),color="blue")+
  geom_text_repel(data=df2,aes(x=ymd(may_date),y=may_pop,label=may_name), size=4,color="blue")+
  
  coord_cartesian(ylim=c(30,100))+
  labs(title="Lady Gaga Album Popularity",
       x="Release Date",
       y="Popularity")+
  annotate("label",x=ymd("2013-12-01"),y=95,label='Lady Gaga albums continue to be popular
  regardless of release date but
           the most popular album is her latest album "Mayhem"', size=3)+
  theme_minimal()

#### Dashboard ####
final_dash <- (cloud_fame | cloud_artpop | cloud_mayhem) /
  (album_senti_plot | song_popsenti_plot | album_date_plot) + 
  plot_layout() +
  plot_annotation(
    title = paste("Lady Gaga Albums Sentiment Analyisis and Popularity"),
    subtitle = paste("Popularity is determined by amount of plays and recency of the plays"),
    caption = 'Source: Spotify API through spotifyr package and lyrics from AZlyrics'
  )

ggsave(filename="midterm2_dash_2.png", plot=final_dash,
       dpi=600, width=15, height=10)
