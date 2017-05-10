class Date
  attr_reader :year, :month
  def initialize (y, m)
    @year = y.to_i
    @month = m.delete ("\"")
  end

  def to_s
    "#{@year},#{@month}"
  end
end

class Population
  attr_accessor :women, :men
  def initialize m, w
    @women = w.to_i
    @men = m.to_i
  end

  def get_total
    if (@women.is_a? Integer and @men.is_a? Integer)
      @women + @men
    else
      @women.get_total + @men.get_total
    end

  end
end

class Age
  attr_accessor :greater_25, :lower_25
  def initialize l, g
    @lower_25 = l.to_i
    @greater_25 = g.to_i
  end

  def get_total
    @lower_25 + @greater_25
  end
end

class Row
  attr_accessor :date, :total_population, :activities, :studies
  def initialize date, total_population, activities, studies
    @activities = activities
    @studies = studies
    @date = date
    @total_population = total_population
  end

end


class FullData
  attr_accessor :content, :activities, :studies, :ages

  def initialize
    @activities = []
    @studies = []
    @ages = []
    @content = []
  end

  def get_total_population
    size = 0
    content.map { |e|
      size += e.total_population.get_total
    }
    puts size
    size
  end


  def create_file
    filename = "values.arff"
    file = File.open(filename, 'w')
    file.puts "@relation paro.symbolic\n\n"

    # Sector
    acv = "@attribute sector {"
    activities.each_with_index.map { |e, i|
      acv += e
      if (i != activities.size - 1)
        acv += ", "
      end
    }
    acv += "}"
    file.puts acv

    # Etudios
    es = "@attribute estudios {"
    studies.each_with_index.map { |e, i|
      es += e
      if (i != studies.size - 1)
        es += ", "
      end
    }
    es += "}"
    file.puts es

    file.puts "@attribute edad {mayor_25, menor_25}"
    file.puts "@attribute sexo {hombre, mujer}"
    file.puts "@attribute mes {enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre}"
    file.puts "@attribute año {2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009}"

    file.puts "\n\n"
    file.puts "@data\n"


    content.map { |element|
      content = ""
      element.activities.each_with_index.map { |act, i|

        content += "#{element.date},"
        content += "mujer,menor_25,#{act.women.lower_25} #{activities[i]}"
        content += "\n"

        content += "#{element.date},"
        content += "mujer,mayor_25,#{act.women.greater_25} #{activities[i]}"
        content += "\n"

        content += "#{element.date},"
        content += "hombre,menor_25,#{act.men.lower_25} #{activities[i]}"
        content += "\n"

        content += "#{element.date},"
        content += "hombre,mayor_25,#{act.men.greater_25} #{activities[i]}"
        content += "\n"

        content += "\n"

      }
      file.puts content
    }

  end

end

def parse_activities line, full
  line = line.split(',')
  line.map { |e|
    full.activities << e.delete("\"")
  }
end

def parse_studies line, full
  line = line.split(',')
  line.map { |e|
    full.studies << e.delete("\"")
  }
end

def parse_ages line, full
  line = line.split(',')
  line.map { |e|
    full.ages << e.delete("\"")
  }
end

def parse_regular_line line, full
  line = line.split(',')

  date = Date.new line[0], line[1]
  # Población total
  total_population = Population.new line[2], line[3]

  index = 4
  activities = []

  # Actividades
  full.activities.each_with_index.map { |e, i|
    #puts "#{e} #{line[index + i * 2]} #{line[index + i * 2 + 1]}"
    pop = Population.new line[index + i * 2], line[index + i * 2 + 1]
    activities << pop
  }

  index = 4 + full.activities.size * 2
  studies = []

  # Nivel de estudios
  full.studies.each_with_index.map { |e, i|
    #puts "#{i + index} #{line[i + index]} #{e}"
    studies << line[i]
  }

  index += full.studies.size

  # Edad
  #puts "#{line[index]} #{line[index + 1]}"
  age = Age.new line[index], line[index + 1]


  # calcula los porcentajes de mujeres y hombres mayores y menos de 25 años
  activities.map { |e|

    total_men = total_population.men
    total_women = total_population.women

    percent_gr_25 = age.greater_25.to_f / total_population.get_total.to_f
    percent_ls_25 = age.lower_25.to_f / total_population.get_total.to_f

    women_gr = e.women.to_f * percent_gr_25
    women_ls = e.women.to_f * percent_ls_25
    men_gr = e.men.to_f * percent_gr_25
    men_ls = e.men.to_f * percent_ls_25

    e.women   = Age.new women_gr.to_i, women_ls.to_i
    e.men     = Age.new men_gr.to_i, men_ls.to_i
  }


  row = Row.new date, total_population, activities, studies
  if (row.total_population.get_total == line[index + 2].to_i)
    puts "Correcto"
    full.content << row
  else
    puts "Fallo, #{row.total_population.get_total} != #{line[index + 2]}"
    puts line [0] + " " + line[1]
  end

end

module FileTid
  filename = "TID_CSV.csv"

  data = FullData.new

  if (File.file?(filename))
    puts "Archivo abierto"
    file = File.open(filename, 'r')
    parse_activities file.readline, data
    parse_studies file.readline, data
    parse_ages file.readline, data
    while !file.eof?
       parse_regular_line file.readline, data
    end

    data.create_file

  else
    puts "No se pudo abrir el archivo"
  end
end
