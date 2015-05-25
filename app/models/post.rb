class Post < ActiveRecord::Base
  validates :body,:title,presence: true
  has_and_belongs_to_many :words
  before_save :evaluate
  HAPPY_VALUE = 1
  SAD_VALUE = -1

  def evaluate
    self.rate = 0
    self.evaluated = 0
    words.destroy_all
    evaluate_words
  end

  def evaluate_words
    words = self.body.split(' ')  + self.title.split(' ')
    words.each do |word|
       match = Word.conjugation_search(word.downcase) if word.length > 3
       unless match.empty?
        self.words << match
        self.rate += match.first.kind ? HAPPY_VALUE : SAD_VALUE
        self.evaluated += 1
       end
    end
  end

end
