# frozen_string_literal: true

require_relative "../lib/ts_recommend"
require 'colorize'

RSpec.describe TaylorSwiftRecommend do
  describe ".recommend_song" do
    context "when the user selects a valid mood" do
      it "recommends a song from the happy mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("happy")
        expect { TaylorSwiftRecommend.recommend_song(:happy) }.to output(/Today, I recommend the song:/).to_stdout
      end

      it "recommends a song from the sad mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("sad")
        expect { TaylorSwiftRecommend.recommend_song(:sad) }.to output(/Today, I recommend the song:/).to_stdout
      end

      it "recommends a song from the angry mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("angry")
        expect { TaylorSwiftRecommend.recommend_song(:angry) }.to output(/Today, I recommend the song:/).to_stdout
      end

      it "recommends a song from the relaxed mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("relaxed")
        expect { TaylorSwiftRecommend.recommend_song(:relaxed) }.to output(/Today, I recommend the song:/).to_stdout
      end

      it "recommends a song from the nostalgic mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("nostalgic")
        expect { TaylorSwiftRecommend.recommend_song(:nostalgic) }.to output(/Today, I recommend the song:/).to_stdout
      end

      it "recommends a song from the romantic mood" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("romantic")
        expect { TaylorSwiftRecommend.recommend_song(:romantic) }.to output(/Today, I recommend the song:/).to_stdout
      end
    end

    context "when the user selects an invalid mood" do
      it "returns a message indicating the mood is not recognized" do
        allow(TaylorSwiftRecommend).to receive(:gets).and_return("excited")
    
        # Se debe eliminar el .red de la linea 98, poara que pase este modulo, del archivo ts_recommend.rb
        expect { TaylorSwiftRecommend.recommend_song(:excited) }
          .to output("Sorry, I don’t recognize that mood. Please try again.\n").to_stdout
      end
    end    
  end
end
