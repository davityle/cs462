ruleset see_songs {
  rule songs is active {
    select when echo message input "(.*)" setting(m) 
    if event:attr("msg_type").match("song")
    then
      send_directive("sing") with 
        song = m;
  }
}

