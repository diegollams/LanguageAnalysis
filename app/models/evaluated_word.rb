class EvaluatedWord < ActiveRecord::Base
  belongs_to :word
  belongs_to :post
end
