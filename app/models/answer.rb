class Answer < ApplicationRecord
  belongs_to :customer
  belongs_to :question
  belongs_to :acceptance_criterium
  belongs_to :satisfaction_questionary
end
