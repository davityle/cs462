ruleset see_songs {
  rule songs is active {
    select when echo message input "(.*)" setting(m)
    send_directive("sing") with 
      song = m;
  }
}

