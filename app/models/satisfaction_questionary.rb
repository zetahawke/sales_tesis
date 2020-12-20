class SatisfactionQuestionary < ApplicationRecord
  belongs_to :visit
  has_one :customer, through: :visit
  has_many :answers, dependent: :destroy
  has_many :acceptance_criteria, through: :answers

  after_create :generate_public_token
  after_create :send_notification

  delegate :match_name, to: :visit, prefix: true

  class << self
    def save_massive(sq_params, salesmen_params)
      salesmen_params[:salesmen].each do |salesman_id|
        salesman = Salesman.find_by(id: salesman_id)
        next unless salesman_id

        salesman.visits.unquestioned.each do |visit|
          SatisfactionQuestionary.create(visit_id: visit.id, questions: sq_params[:questions])
        end
      end
      true
    rescue StandardError => _e
      false
    end
  end

  def found_questions
    Question.where(id: questions || [])
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
    return unless customer.email

    NotificationMailer.customer_questionary(customer, visit, self).deliver_now
  rescue StandardError => e
    puts e.message
  end

  def public_url
    "#{Rails.configuration.public_url}/public/sq?public_token=#{public_token}"
  end
end
