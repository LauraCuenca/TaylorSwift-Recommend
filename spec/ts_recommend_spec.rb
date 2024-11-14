# frozen_string_literal: true

require_relative "../lib/ts_recommend"
require 'colorize'

RSpec.describe TaylorSwiftRecommend do
  before(:all) do
    @module = TaylorSwiftRecommend
  end

  describe '.songs_json' do
    it 'loads songs data correctly' do
      expect(@module::SONGS).not_to be_empty
      expect(@module::SONGS).to be_a(Hash)
    end
  end

  describe '.ask_for_mood' do
    it 'accepts a valid mood from the user and recommends a song' do
      allow(TaylorSwiftRecommend).to receive(:gets).and_return("happy\n") 
      expect { TaylorSwiftRecommend.ask_for_mood }.to output(/Today, I recommend the song:/).to_stdout
    end
  
    it 'rejects invalid mood input and asks again' do
      allow(TaylorSwiftRecommend).to receive(:gets).and_return("unknown_mood\n")
      expect { TaylorSwiftRecommend.ask_for_mood }.to output(/How are you feeling today?/).to_stdout
      expect { TaylorSwiftRecommend.ask_for_mood }.to output(/I’ll recommend a Taylor Swift song based on your mood./).to_stdout
    end
  end
  

  describe '.recommend_song' do
    context 'when mood is known' do
      it 'recommends a song based on the mood' do
        expect { TaylorSwiftRecommend.recommend_song(:happy) }.to output(/Today, I recommend the song:/).to_stdout
      end
    end

    context 'when mood is unknown' do
      it 'outputs an error message' do
        expect { @module.recommend_song(:unknown_mood) }.to output(/Sorry, I don’t recognize that mood/).to_stdout
      end
    end
  end

  describe '.remove_song_from_mood' do
    it 'removes a specific song from a given mood' do
      song_to_remove = @module::SONGS[:happy].first[:song]
      expect { @module.remove_song_from_mood(:happy, song_to_remove) }.to output(/eliminada del estado de ánimo/).to_stdout
      expect(@module::SONGS[:happy].map { |s| s[:song] }).not_to include(song_to_remove)
    end
  end

  describe '.add_song_to_mood' do
    it 'adds a new song to a given mood' do
      @module.add_song_to_mood(:happy, "New Song", "New Album")
      expect(@module::SONGS[:happy].map { |s| s[:song] }).to include("New Song")
    end
  end

  describe '.create_mood' do
    it 'creates a new mood with specified songs' do
      mood_name = :excited
      @module.create_mood(mood_name, ["Exciting Song"])
      expect(@module::SONGS[mood_name].first[:song]).to eq("Exciting Song")
    end
  end

  describe '.delete_mood' do
    it 'deletes a specified mood' do
      mood_name = :test_mood
      @module.create_mood(mood_name, ["Test Song"])
      @module.delete_mood(mood_name)
      expect(@module::SONGS.key?(mood_name)).to be(false)
    end
  end

  describe '.recommend_song_by_album' do
    context 'when album is known' do
      it 'recommends a song from a specific album' do
        expect { @module.recommend_song_by_album("Red (Taylor's Version)") }.to output(/I recommend/).to_stdout
      end
    end

    context 'when album is unknown' do
      it 'outputs an error message' do
        expect { @module.recommend_song_by_album("Unknown Album") }.to output(/No songs found for that album/).to_stdout
      end
    end
  end
end
