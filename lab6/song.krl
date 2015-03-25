ruleset see_songs {
   meta {
    logging on
  }

  rule songs is active {
    select when echo message msg_type "song" input re#(.*)# setting(m)
      send_directive("sing") with 
        song = m;
    fired {
      log "raising sung event";
      raise explicit event sung with song = m
    }
  }
  rule find_hymn is active {
    select when explicit sung song "(.*god.*)" 
    fired {
      log "raising found_hymn event";
      raise explicit event found_hymn
    }
  }
}

