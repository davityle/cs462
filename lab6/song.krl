ruleset see_songs {
   meta {
    logging on
  }

  rule songs is active {
    select when echo message input "(.*)" setting(m) 
    if event:attr("msg_type").match("song")
    then
      send_directive("sing") with 
        song = m;
  }
  rule find_hymn is active {
    select when explicit sung song "(.*god.*)" 
    fired {
      log "raising found_hymn event";
      raise explicit event found_hymn
    }
  }
}

