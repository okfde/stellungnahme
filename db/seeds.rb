# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ministries = Ministry.create(
  [
    { name: 'Auswärtiges Amt', short_name: 'AA' },
    { name: 'Bundesministerium der Finanzen', short_name: 'BMF' },
    { name: 'Bundesministerium der Justiz und für Verbraucherschutz', short_name: 'BMJV' },
    { name: 'Bundesministerium der Verteidigung', short_name: 'BMVg' },
    { name: 'Bundesministerium des Innern', short_name: 'BMI' },
    { name: 'Bundesministerium für Arbeit und Soziales', short_name: 'BMAS' },
    { name: 'Bundesministerium für Bildung und Forschung', short_name: 'BMBF' },
    { name: 'Bundesministerium für Ernährung und Landwirtschaft', short_name: 'BMEL' },
    { name: 'Bundesministerium für Familie, Senioren, Frauen und Jugend', short_name: 'BMFSFJ' },
    { name: 'Bundesministerium für Gesundheit', short_name: 'BMG' },
    { name: 'Bundesministerium für Umwelt, Naturschutz, Bau und Reaktorsicherheit', short_name: 'BMUB' },
    { name: 'Bundesministerium für Verkehr und digitale Infrastruktur', short_name: 'BMVI' },
    { name: 'Bundesministerium für wirtschaftliche Zusammenarbeit und Entwicklung', short_name: 'BMZ' },
    { name: 'Bundesministerium für Wirtschaft und Energie', short_name: 'BMWi' },
    { name: 'Beauftragter der Bundesregierung für Kultur und Medien' }
  ]
)
