class Answer < ApplicationRecord
  belongs_to :customer
  belongs_to :question
  belongs_to :acceptance_criteria
  belongs_to :satisfaction_questionary
end
