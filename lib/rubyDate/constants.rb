module RubyDate::Constants
  FORMATS = Hash[
    :fr => "%A %d %B %Y %T",
    :en => "%A, %B %d %r"
  ]
  LANGS = Hash[
    :fr => Hash[
      :months => Hash[
        "January" => "Janvier",
        "February" => "Février",
        "March" => "Mars",
        "April" => "Avril",
        "May" => "Mai",
        "June" => "Juin",
        "July" => "Juillet",
        "August" => "Aout",
        "September" => "Septembre",
        "October" => "Octobre",
        "November" => "Novembre",
        "December" => "Décembre",
      ],
      :days => Hash[
        "Monday" => "Lundi",
        "Tuesday" => "Mardi",
        "Wednesday" => "Mercredi",
        "Thursday" => "Jeudi",
        "Friday" => "Vendredi",
        "Saturday" => "Samedi",
        "Sunday" => "Dimanche"
      ]
    ]
  ]
end
