class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  before_destroy :erase_question_from_satisfaction_questionaries

  def found_acceptance_criterias
    AcceptanceCriterium.where(id: acceptance_criterias || [])
  end

  def erase_question_from_satisfaction_questionaries
    sat_ques = SatisfactionQuestionary.all.select { |sat_que| sat_que.questions.include? id }
    sat_ques.each do |sat_que|
      questions = sat_que.questions.delete_if { |question| question == id }
      sat_que.update_columns(questions: questions)
    end
  end
end
