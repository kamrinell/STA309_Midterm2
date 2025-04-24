library(spotifyr)
#### access Spotify API with access token
SPOTIFY_CLIENT_ID <- '417f59f74d2a4125a3f02b3dfd58d35d'
SPOTIFY_CLIENT_SECRET <- '4cab3b3b203045d2a7ee997050a8bf87'
access_token <- get_spotify_access_token(SPOTIFY_CLIENT_ID,SPOTIFY_CLIENT_SECRET)

# Albums
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

# Songs
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