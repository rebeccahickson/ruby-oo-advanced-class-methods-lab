require 'pry'

class Song
  attr_accessor :name, :artist_name

  @@all = []

  def initialize(name = nil, artist_name = nil)
    @name = name
    @artist_name = artist_name
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = new
    @@all << new_song
    new_song
  end

  def self.new_by_name(name)
    new_song = new(name)
  end

  def self.create_by_name(name)
    @@all << new_song = new(name)
    new_song
  end

  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(song_name)
    # rubocop:disable Rails/DynamicFindBy
    find_by_name(song_name) || create_by_name(song_name)
    # rubocop:enable Rails/DynamicFindBy
  end

  def self.alphabetical
    @@all.sort_by(&:name)
  end

  def self.new_from_filename(input)
    content = input.split(' - ')
    new(content[1].chomp('.mp3'), content[0])
  end

  def self.create_from_filename(input)
    new_song = new_from_filename(input)
    @@all << new_song
  end

  def self.destroy_all
    @@all.clear
  end
end
