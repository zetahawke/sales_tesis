class Question < ApplicationRecord
  has_one :answer, dependent: :destroy

  def found_acceptance_criterias
    AcceptanceCriterium.where(id: acceptance_criterias || [])
  end
end
