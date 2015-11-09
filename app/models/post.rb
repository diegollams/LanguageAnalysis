class Post < ActiveRecord::Base
  validates :body,:title,presence: true
  has_and_belongs_to_many :words
  before_save :evaluate
  has_many :evaluated_words

  HAPPY_VALUE = 1
  SAD_VALUE = -1

  NEGATION_WORDS = %w[ no nunca jamas]
  ENHANCERS = %w[muy mucho demasiado exagerado]
  REDUCERS = %w[poco nada ]

  def evaluate
    self.evaluated = 0
    self.sum = 0
    words.destroy_all
    evaluate_words
  end

  def create_message
    positive_words = self.positive_words.count
    negative_words = self.negative_words.count
    doubt_words = self.doubt_words.count
    if self.sum > 0
      rate = (positive_words * 100) / (positive_words + negative_words + doubt_words)
      message  = "Este post tiene una evaluacion de pensamientos positiva debido a que el rating es de #{sum}, y cuenta con #{positive_words} palabras positivas
                    y tan solo cuenta con #{negative_words} palabras negativas y #{doubt_words} palabras de duda"


    elsif self.sum < 0
      rate = (negative_words * 100) / (positive_words + negative_words  + doubt_words)
      message = "Este post tiene una evaluacion de pensamiento negativos debido a que el rating es de #{sum}, y cuenta con #{negative_words} palabras negativas
                    y tan solo cuenta con #{positive_words} palabras positivas y  #{doubt_words} palabras de duda"
    else
      message = "Este post tiene una evaluacion de neutral debido a que el rating es de de 0, y cuenta con #{negative_words} palabras negativas
                 y con #{positive_words} palabras positivas y  #{doubt_words} palabras de duda"
      rate = 0
    end
    update_attribute('message', message)
    update_attribute('rate', rate)
  end

  def positive_words
    words.where(kind: Word::KIND_HAPPY)
  end

  def negative_words
    words.where(kind: Word::KIND_SAD)
  end

  def doubt_words
    words.where(kind: Word::KIND_DOUBT)
  end

  def evaluate_words
    # here we save if get a negation we change the meaning of the folowing word
    negation_word = false
    words = self.body.split(/\s|\.|\,/)  + self.title.split(/\s|\.|\,/)
    words.each do |word|
       if word.length < 3
         if NEGATION_WORDS.include? word.downcase
           negation_word =  true
         end
         next
       end
      if NEGATION_WORDS.include? word.downcase
        negation_word =  true
      end
      match = Word.conjugation_search(word.downcase)
       unless match.empty?
        self.words << match
        # if thera was a negation before the word we change the sense of
        if negation_word
         if match.first.happy?
           self.sum += SAD_VALUE
           self.sum += SAD_VALUE if word.include? '!'
         else
           self.sum += HAPPY_VALUE
           self.sum += HAPPY_VALUE if word.include? '!'
          end

        else

          if match.first.happy?
            self.sum += HAPPY_VALUE
            self.sum += HAPPY_VALUE if word.include? '!'
          else
            self.sum += SAD_VALUE
            self.sum += SAD_VALUE if word.include? '!'
          end

        end
        self.evaluated += 1
        negation_word = false
       end
    end
  end

end
