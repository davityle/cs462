ruleset song_store {
   meta {
    logging on
    provides songs, hymns, secular_music
    sharing on
  }

  global {
    hymns = function() {
      songs = ent:entHymns
      songs
    };

    songs = function(){
      songs = ent:entSongs
      songs
    };
    secular_music = function(){
      query_results = ent:entSongs.query([], { 
       'requires' : '$and',
       'conditions' : [
          { 
           'operator' : '$regex',
           'value' : "^(.*god.*)" 
        }
      ]},
      "return_values"
      );
      query_results
    };
  }

  rule collect_songs is active {
    select when explicit sung song re#(.*)# setting(m)
    pre {
      songs = ent:entSongs || [];
      new_array = songs.union(m)
    }
    always {
      set ent:entSongs new_array if (not songs.has(m));
    }
  }
  rule collect_hymns is active {
    select when explicit found_hymn song re#(.*)# setting(m)
    pre {
      hymns = ent:entHymns || [];
      //x = { "hymn" : m, "time" : time:now()}
      new_array = hymns.union(m)
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

