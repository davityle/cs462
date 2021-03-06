ruleset song_store {
   meta {
    name "Song Store"
    author "Tyler Davis"
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
      songs = ent:entSongs
      songs.filter(function(x){ x.match(re/!(.*god.*)/);})
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

