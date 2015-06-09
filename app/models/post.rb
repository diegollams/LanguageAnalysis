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
    create_message
  end

  def create_message
    if rate > 0
      self.message  = "Este post tiene una evaluacion de pensamientos positiva debido a que si rating es de #{rate}, y cuenta con #{positive_words.count} palabras positivas
                    y tan solo cuenta con #{negative_words.count} palabras negativas"
    elsif rate < 0
      self.message = "Este post tiene una evaluacion de pensamioentos debido a que si rating es de #{rate}, y cuenta con #{negative_words.count} palabras negativcas
                    y tan solo cuenta con #{positive_words.count} palabas positivas"
    else
      self.message = "Este post tiene una evaluacion de netrual debido a que si rating es de de 0, y cuenta con #{negative_words.count} palabras negativas
                    y tan solo cuenta con #{positive_words.count} palabras positivas"
    end
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
        self.rate += match.first.kind ? HAPPY_VALUE : SAD_VALUE
        self.evaluated += 1
       end
    end
  end

end
