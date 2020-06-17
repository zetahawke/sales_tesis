class SatisfactionQuestionary < ApplicationRecord
  belongs_to :visit

  def found_questions
    Question.where(id: questions || [])
  end
end
