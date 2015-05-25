class Post < ActiveRecord::Base
  validates :body,:title,presence: true
  has_and_belongs_to_many :words
  before_save :evaluate
  HAPPY_VALUE = 1
  SAD_VALUE = -1

  def evaluate
    self.rate = 0
    self.evaluated = 0
    evaluate_words('happy',HAPPY_VALUE)
    evaluate_words('sad',SAD_VALUE)
  end

  def evaluate_words(type,value)
    happy_words =  instance_eval "Word.#{type}_to_hash"
    words = self.body.split(' ')  + self.title.split(' ')
    words.each do |word|
       unless happy_words[word].nil?
        self.rate += value
        self.evaluated += 1
       end
    end
  end

  # verify if this method is cleaner or evaluate_words
  # def evaluate_happy
  #   happy_words = Word.happy_to_hash
  #   words = self.body.split(' ')  + self.title.split(' ')
  #   words.each do |word|
  #     if happy_words[word]
  #       self.rate += HAPPY_VALUE
  #       self.evaluated += 1
  #     end
  #   end
  # end


end
