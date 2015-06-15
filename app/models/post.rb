class Post < ActiveRecord::Base
  validates :body,:title,presence: true
  has_and_belongs_to_many :words
  before_save :evaluate

  HAPPY_VALUE = 1
  SAD_VALUE = -1

  def evaluate
    self.evaluated = 0
    words.destroy_all
    evaluate_words
  end

  def create_message
    positive_words = self.positive_words.count
    negative_words = self.negative_words.count
    if self.sum > 0
      rate = (positive_words * 100) / (positive_words + negative_words)
      message  = "Este post tiene una evaluacion de pensamientos positiva debido a que el rating es de #{rate}, y cuenta con #{positive_words} palabras positivas
                    y tan solo cuenta con #{negative_words} palabras negativas"


    elsif self.sum < 0
      rate = (negative_words * 100) / (positive_words + negative_words)
      message = "Este post tiene una evaluacion de pensamiento negativos debido a que el rating es de #{rate}, y cuenta con #{negative_words} palabras negativas
                    y tan solo cuenta con #{positive_words} palabras positivas"
    else
      message = "Este post tiene una evaluacion de neutral debido a que el rating es de de 0, y cuenta con #{negative_words} palabras negativas
                 y con #{positive_words} palabras positivas"
      rate = 0
    end
    update_attribute('message', message)
    update_attribute('rate', rate)
  end

  def positive_words
    words.where(kind: true)
  end

  def negative_words
    words.where(kind: false)
  end

  def evaluate_words
    words = self.body.split(/\s|\.|\,/)  + self.title.split(/\s|\.|\,/)
    words.each do |word|
       next if word.length < 3
       match = Word.conjugation_search(word.downcase)
       unless match.empty?
        self.words << match
        self.sum += match.first.kind ? HAPPY_VALUE : SAD_VALUE
        self.evaluated += 1
       end
    end
  end

end
