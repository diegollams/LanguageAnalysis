class Word < ActiveRecord::Base
  # Kind is the type of word when evaluate if is true is a happy word
  # if is false it is a sad word
  validates :content ,presence: true
  before_save :content_downcase
  validates_uniqueness_of :content

  has_and_belongs_to_many :posts

  def self.happy_words
    where kind: true
  end

  def self.sad_words
    where kind: false
  end



  def self.all_to_hash
    to_dictionary all
  end

  def self.happy_to_hash
    to_dictionary happy_words
  end

  def self.sad_to_hash
    to_dictionary sad_words
  end




  private
  def content_downcase
    content.downcase!
    content.remove! ' '
  end

  def self.to_dictionary(words)
    hash = {}
    words.each do |word|
      hash[word.content] = word.kind
    end
    hash
  end
end
