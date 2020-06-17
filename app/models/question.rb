class Question < ApplicationRecord
  def found_acceptance_criterias
    AcceptanceCriterium.where(id: acceptance_criterias || [])
  end
end
