class EvaluatedWord < ActiveRecord::Base
  belongs_to :words
  belongs_to :posts
end
