class SatisfactionQuestionary < ApplicationRecord
  belongs_to :visit
  has_one :customer, through: :visit

  after_create :generate_public_token
  after_create :send_notification

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

  def generate_public_token
    token = Devise.friendly_token
    update_columns(public_token: token)
  end

  def send_notification
    NotificationMailer.customer_questionary(customer, visit, self).deliver_now
  end

  def public_url
    "#{Rails.configuration.public_url}/public/sq?public_token=#{public_token}"
  end
end
