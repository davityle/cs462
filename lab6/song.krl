ruleset see_songs {
  rule songs is active {
    select when echo message input "(.*)" setting(m) 
    if event:attr("msg_type").match("song")
    then
      send_directive("sing") with 
        song = m;
  }
  rule find_hymn is active {
    select when explicit sung 
       raise explicit event explicit found_hymn
  }
}

