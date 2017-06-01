# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ministries = Ministry.create(
  [
    { name: 'Justiz und Verbraucherschutz', short_name: 'BMJV' },
    { name: 'Gesundheit', short_name: 'BMG' },
    { name: 'Auswärtiges Amt', short_name: 'AA' },
    { name: 'Wirtschaft und Energie', short_name: 'BMWi' },
    { name: 'Wirtschaftliche Zusammenarbeit und Entwicklung', short_name: 'BMZ' },
    { name: 'Inneres', short_name: 'BMI' },
    { name: 'Finanzen', short_name: 'BMF' },
    { name: 'Arbeit und Soziales', short_name: 'BMAS' },
    { name: 'Umwelt, Naturschutz, Bau und Reaktorsicherheit', short_name: 'BMUB' },
    { name: 'Bildung und Forschung', short_name: 'BMBF' },
    { name: 'Verkehr und digitale Infrastruktur', short_name: 'BMVI' },
    { name: 'Verteidigung', short_name: 'BMVg' },
    { name: 'Familie, Senioren, Frauen und Jugend', short_name: 'BMFSFJ' },
    { name: 'Ernährung und Landwirtschaft', short_name: 'BMEL' },
    { name: 'Kanzleramt und Medien' }
  ]
)