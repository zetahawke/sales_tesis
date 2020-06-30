# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'zhawke@admin.cl', password: 'password', password_confirmation: 'password') unless User.find_by(email: 'zhawke@admin.cl')
User.create!(email: 'admin@evares.com', password: 'password', password_confirmation: 'password') unless User.find_by(email: 'admin@evares.com')

acceptance_criteria = [
  ['numeric field 0', 'integer', '0', 0],
  ['numeric field 1', 'integer', '1', 0],
  ['numeric field 2', 'integer', '2', 0],
  ['numeric field 3', 'integer', '3', 0],
  ['numeric field 4', 'integer', '4', 0],
  ['numeric field 5', 'integer', '5', 0],
  ['numeric field 6', 'integer', '6', 0],
  ['numeric field 7', 'integer', '7', 1],
  ['numeric field 8', 'integer', '8', 1],
  ['numeric field 9', 'integer', '9', 3],
  ['numeric field 10', 'integer', '10', 3],
  ['word field 0', 'string', 'muy malo', 0],
  ['word field 1', 'string', 'malo', 0],
  ['word field 2', 'string', 'normal', 1],
  ['word field 3', 'string', 'bueno', 3],
  ['word field 4', 'string', 'muy bueno', 3],
  ['recomendation field 0', 'string', 'no lo recomiendo', 0],
  ['recomendation field 1', 'string', 'indiferente', 1],
  ['recomendation field 2', 'string', 'lo recomiendo', 3]
]

acceptance_criteria.each do |ac|
  a,b,c,d = ac
  AcceptanceCriterium.create!(name: a, criteria: b, criteria_value: c, hit_value: d) unless AcceptanceCriterium.find_by(name: a)
end

questions = [
  [
    'Calidad del Servicio',
    'Selecciona la opción que mejor refleje la calidad de servicio que percibes.',
    11.times.map { |t| "numeric field #{t}" }
  ],
  [
    'Servicio al Cliente',
    'Cuentanos como fué la atención que recibiste de nuestro agentes',
    5.times.map { |t| "word field #{t}" }
  ],
  [
    'Vendedor',
    'Recomendarías al vendedor que te atendió a algún familiar o amigo?',
    3.times.map { |t| "recomendation field #{t}" }
  ],
  [
    'Valores',
    'Califica como encuentras que son los valores que entrega nuestra compañía.',
    11.times.map { |t| "numeric field #{t}" }
  ],
  [
    'Seguridad',
    'Sentiste que nuestro vendedor respetó los conductos sanitarios actuales?',
    11.times.map { |t| "numeric field #{t}" }
  ]
]

questions.each do |q|
  a,b,c = q
  Question.create!(
    name: a,
    description: b,
    acceptance_criterias: AcceptanceCriterium.where(name: c).pluck(:id)
  ) unless Question.find_by(name: a)
end
