class Word < ActiveRecord::Base
  # Kind is the type of word when evaluate if is true is a happy word
  # if is false it is a sad word
  validates :content ,presence: true
  before_save :content_downcase
  validates_uniqueness_of :content

  has_and_belongs_to_many :posts

  KIND_HAPPY = 'happy'
  KIND_SAD = 'sad'
  KIND_DOUBT = 'doubt'

  def self.conjugation_search(query)
    if query.present?
      where("content % ?",query).where("similarity(content, '#{query}') > 0.3").order("similarity(content, '#{query}') DESC").limit 1
    else
      where content: ''
    end
  end


  scope :happy_words, ->{where king: KIND_HAPPY}
  scope :sad_words, ->{where king: KIND_SAD}
  scope :doubt_words, ->{where king: KIND_DOUBT}

  def happy?
    kind == KIND_HAPPY
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
