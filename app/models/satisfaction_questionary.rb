class SatisfactionQuestionary < ApplicationRecord
  belongs_to :visit

  def found_questions
    Question.where(id: questions || [])
  end

  def answers
    Answer.where(question_id: found_questions.pluck(:id))
  end

  def acceptance_criteria
    AcceptanceCriterium.where(id: answers.pluck(:acceptance_criteria_id))
  end

  def accomplishment_percent
    return 0 if found_questions.size.zero? || answers.size.zero?

     (100 / max_accomplishment_points) * accomplishment_points
  end

  def max_accomplishment_points
    return 0 if found_questions.size.zero?

    found_questions.size * 3
  end

  def accomplishment_points
    return 0 if answers.size.zero?

    acceptance_criteria.sum(:hit_value)
  end

  def accomplished
    accomplishment_percent >= 80
  end
end
