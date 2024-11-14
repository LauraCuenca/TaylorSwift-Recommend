# frozen_string_literal: true

require_relative "ts_recommend/version"
require 'colorize'
require 'json'

module TaylorSwiftRecommend
  class Error < StandardError; end

  def self.songs_json
    file_path = File.expand_path('../../data/records.json', __FILE__)
    data = JSON.parse(File.read(file_path))
    categories = {
      happy: ["Shake It Off", "You Belong With Me", "22", "We Are Never Ever Getting Back Together", "ME!", "Blank Space", "Cruel Summer"],
      sad: ["All Too Well", "Back to December", "Teardrops on My Guitar", "White Horse", "My Tears Ricochet", "Betty"],
      angry: ["Look What You Made Me Do", "I Knew You Were Trouble", "Better Than Revenge", "Mad Woman", "champagne problems", "tolerate it"],
      relaxed: ["Lover", "Invisible String", "Peace", "Stay Stay Stay", "Begin Again", "dorothea"],
      nostalgic: ["Tim McGraw", "The Best Day", "Ronan", "Last Kiss", "Long Live", "The Profecy", "Fortnight"],
      romantic: ["Enchanted", "Call It What You Want", "Invisible String", "Fearless"]
    }

    songs = Hash.new { |h, k| h[k] = [] }
    
    data["albums"].each do |album|
      album["songs"].each do |song|
        categories.each do |mood, titles|
          if titles.include?(song["title"])
            songs[mood] << { song: song["title"], album: album["title"] }
          end
        end
      end
    end
    
    songs
  end

  SONGS = songs_json

  ALBUM_COLORS = {
    "Taylor Swift" => :cyan,
    "Fearless (Taylor's Version)" => :yellow,
    "Speak Now (Taylor's Version)" => :magenta,
    "Red (Taylor's Version)" => :red,
    "1989 (Taylor's Version)" => :light_blue,
    "Reputation" => :white,
    "Lover" => :magenta,
    "Folklore" => :light_black,
    "Evermore" => :brown,
    "Midnights" => :blue,
    "The Tortured Poets Department" => :gray
  }

  def self.remove_song_from_mood(mood, song_title)
    if SONGS[mood]
      SONGS[mood].reject! { |song| song[:song] == song_title }
      puts "Canción '#{song_title}' eliminada del estado de ánimo '#{mood}'."
    else
      puts "No existe el estado de ánimo '#{mood}'."
    end
  end

  def self.add_song_to_mood(mood, song_title, album_name)
    SONGS[mood] << { song: song_title, album: album_name }
    puts "Canción '#{song_title}' añadida al estado de ánimo '#{mood}'."
  end

  def self.create_mood(mood, song_titles)
    SONGS[mood] = song_titles.map { |title| { song: title, album: "Unknown" } }
    puts "Nuevo estado de ánimo '#{mood}' creado con canciones: #{song_titles.join(', ')}."
  end

  def self.delete_mood(mood)
    if SONGS.key?(mood)
      SONGS.delete(mood)
      puts "Estado de ánimo '#{mood}' eliminado."
    else
      puts "El estado de ánimo '#{mood}' no existe."
    end
  end

  def self.ask_for_album
    puts "Choose an album to filter songs by:".blue
    ALBUM_COLORS.each_key do |album|
      puts "- #{album}".colorize(ALBUM_COLORS[album])
    end
    album_choice = gets.chomp
    recommend_song_by_album(album_choice)
  end
  
  def self.recommend_song_by_album(album_name)
    songs_in_album = SONGS.values.flatten.select { |song| song[:album] == album_name }
    if songs_in_album.any?
      song = songs_in_album.sample
      puts "I recommend '#{song[:song]}' from '#{album_name}'.".colorize(ALBUM_COLORS[album_name])
    else
      puts "No songs found for that album.".red
    end
  end
  

  def self.ask_for_mood
    puts "How are you feeling today?".blue
    puts "I’ll recommend a Taylor Swift song based on your mood.".blue
  
    SONGS.keys.each do |mood|
      puts "- #{mood}".colorize(:light_blue)
    end
  
    mood = gets.chomp.downcase.to_sym
    recommend_song(mood)
  end
  

  def self.recommend_song(mood)
    song = SONGS[mood]&.sample
    return puts "Sorry, I don’t recognize that mood. Please try again.".red unless song
  
    album_color = ALBUM_COLORS[song[:album]] || :default
    puts "Today, I recommend the song: '#{song[:song].colorize(album_color)}' from the album '#{song[:album].colorize(album_color)}'."
  end
  
  def self.run
    ask_for_mood
  end
end

# Inicia el programa
TaylorSwiftRecommend.run

