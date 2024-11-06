# frozen_string_literal: true

require_relative "ts_recommend/version"
require 'colorize'

module TaylorSwiftRecommend
  class Error < StandardError; end

  SONGS = {
    happy: [
      { song: "Shake It Off", album: "1989" },
      { song: "You Belong With Me", album: "Fearless" },
      { song: "22", album: "Red" },
      { song: "We Are Never Ever Getting Back Together", album: "Red" },
      { song: "ME!", album: "Lover" },
      { song: "Blank Space", album: "1989" },
      { song: "Cruel Summer", album: "Lover" }
    ],
    sad: [
      { song: "All Too Well", album: "Red" },
      { song: "Back to December", album: "Speak Now" },
      { song: "Teardrops on My Guitar", album: "Taylor Swift" },
      { song: "White Horse", album: "Fearless" },
      { song: "My Tears Ricochet", album: "Folklore" },
      { song: "Betty", album: "Folklore" }
    ],
    angry: [
      { song: "Look What You Made Me Do", album: "Reputation" },
      { song: "I Knew You Were Trouble", album: "Red" },
      { song: "Better Than Revenge", album: "Speak Now" },
      { song: "Mad Woman", album: "Folklore" },
      { song: "champagne problems", album: "Evermore" },
      { song: "tolerate it", album: "Evermore" }
    ],
    relaxed: [
      { song: "Lover", album: "Lover" },
      { song: "Invisible String", album: "Folklore" },
      { song: "Peace", album: "Folklore" },
      { song: "Stay Stay Stay", album: "Red" },
      { song: "Begin Again", album: "Red" },
      { song: "dorothea", album: "Evermore" }
    ],
    nostalgic: [
      { song: "Tim McGraw", album: "Taylor Swift" },
      { song: "The Best Day", album: "Fearless" },
      { song: "Ronan", album: "Red" },
      { song: "Last Kiss", album: "Speak Now" },
      { song: "Long Live", album: "Speak Now" },
      { song: "The Profecy", album: "TTPD" },
      { song: "Fortnight", album: "TTPD" }
    ],
    romantic: [
      { song: "Enchanted", album: "Speak Now" },
      { song: "Call It What You Want", album: "Reputation" },
      { song: "Invisible String", album: "Folklore" },
      { song: "Fearless", album: "Fearless" }
    ]
  }

  ALBUM_COLORS = {
  "1989" => :light_blue,
  "Fearless" => :yellow,
  "Folklore" => :light_black,
  "Evermore" => :brown,
  "Red" => :red,
  "Speak Now" => :magenta,
  "Reputation" => :white,
  "Lover" => :pink,
  "TTPD" => :gray,
  "Taylor Swift" => :cyan,
  "Midnight" => :blue
}

  def self.ask_for_mood
    puts "How are you feeling today?".blue
    puts "I’ll recommend a Taylor Swift song based on your mood.".blue
    puts "- happy".green
    puts "- sad".light_blue
    puts "- angry".red
    puts "- relaxed".yellow
    puts "- nostalgic".magenta
    puts "- romantic".cyan
  
    mood = gets.chomp.downcase.to_sym
    recommend_song(mood)
  end

  def self.recommend_song(mood)
    if SONGS.keys.include?(mood)
      song = SONGS[mood].sample
      album_color = ALBUM_COLORS[song[:album]] || :default
      puts "Today, I recommend the song: '#{song[:song].colorize(album_color)}' from the album '#{song[:album].colorize(album_color)}'."
    else
      puts "Sorry, I don’t recognize that mood. Please try again.".red
      ask_for_mood
    end
  end  
  
  def self.run
      ask_for_mood
    end
  end
  
  # Inicia el programa
  TaylorSwiftRecommend.run