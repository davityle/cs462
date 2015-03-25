ruleset song_store {
   meta {
    logging on
    provides songs
    sharing on
  }

  global {
//  songs = function() {
//  }

    songs = function(){
      ent:entSongs
    };
//    secular_music = function(){
//    }
  }

  rule collect_songs is active {
    select when explicit sung song re#(.*)# setting(m)
    pre {
      songs = ent:entSongs || [];
      new_array = songs.union({ "song" : m, "time" : time:now()})
    }
    always {
      log "storing new ent songs";
      set ent:entSongs new_array if (not songs.has(m))
    }
  }
  rule collect_hymns is active {
    select when explicit found_hymn song re#(.*)# setting(m)
    pre {
      hymns = ent:entHymns || [];
      new_array = hymns.union({ "hymn" : m, "time" : time:now()})
    }
    always {
      set ent:entHymns new_array if (not hymns.has(m))
    }
  }
  rule clear_songs is active {
    select when song reset 
    always {
      clear ent:entSongs;
      clear ent:entHymns;
    }
  }
}