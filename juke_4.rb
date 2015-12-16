class Jukebox
  def initialize
    @playing = "Nothing Playing"
    @songlist =[]
    add_my_songs
    interface
  end

  # user interface
  def interface
    while true
      puts
      puts "Commands: add, list, play, stop, who, delete"
      puts "'CTRL C' to exit"
      input = gets.chomp

      case input
      when "add", "a"
        new_song
      when "list", "l"
        print_songlist
      when "who", "w"
        puts "Now Playing: " + @playing
      when "play", "p"
        play_song
      when "delete", "d"
        delete_song
      when "stop", "s"
        @playing = "Nothing Playing"
        puts "Jukebox Stopped"
      else
        puts "Invalid Command!"
      end
    end
  end

  # choose a song from the songlist to play
  def play_song
    puts "Enter Name of Song:"
    @title_requested = gets.chomp.downcase
    @song_exists = false
    @songlist.each do |song|
      if song.title.downcase == @title_requested then @playing = song.title
        @song_exists = true
      end
    end

    # checks if user input matches a name in the songlist.
    if @song_exists == true then puts "Now Playing: " + @playing
    else
      puts "Can't find that title. Is your spelling correct?"
    end
  end

  def delete_song
    puts "Enter Name of Song:"
    @title_requested = gets.chomp.downcase

    puts "Are you sure you want to delete '" + @title_requested.capitalize + "'? (y/n)"
    y_or_n = gets.chomp.downcase
    if y_or_n == "y"
      @song_exists = false
      @index = 0
      @songlist_copy = @songlist.clone
      @songlist_copy.each do |song|
        if song.title.downcase == @title_requested
          @songlist.delete_at(@index)
          @song_exists = true
        end
        @index += 1
      end

      @songlist.compact!

      # checks if user input matches a name in the songlist.
      if @song_exists == true then puts "Song Deleted!"
      else
        puts "Can't find that title. Is your spelling correct?"
      end
    end
  end

  # add my default songs to the songlist on program start
  def add_my_songs
    @my_songs = [["Hound Dog", "Elvis"], ["Maggie May", "Rod Stewart"],
                 ["My Way", "Frank Sinatra"], ["Mystery Train", "Elvis"]]
    @my_songs.each do |ary|
      song = Song.new(ary[0], ary[1])
      add_song(song)
    end
  end

  def add_song(song)
    @songlist.push song
  end

  def new_song
    print "Enter Song Title: "
    title = gets.chomp
    print "Enter Artist: "
    artist = gets.chomp
    song = Song.new(title, artist)
    add_song(song)
    print_songlist
  end

  def print_songlist
    @songlist.each do |song|
      print "Song: " + song.title
      puts ",  Artist: " + song.artist
    end
  end
end

class String
  def titleize
    self.split(" ").map{|word| word.capitalize}.join(" ")
  end
end

class Song
  attr_accessor :title, :artist
  def initialize(title, artist)
    @title = title.titleize
    @artist = artist.titleize
  end
end

jukebox = Jukebox.new
