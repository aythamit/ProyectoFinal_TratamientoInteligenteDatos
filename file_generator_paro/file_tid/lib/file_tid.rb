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
  attr_accessor :total_population, :activities, :percent_studies, :percent_age, :year

  @percent_age = []
  @percent_studies = []

  def initialize total_population, activities, per_studies, per_age, y
    @year = y
    @activities = activities
    @percent_age = per_age
    @percent_studies = per_studies
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

    # Estudios
    es = "@attribute estudios {"
    studies.each_with_index.map { |e, i|
      es += e
      if (i != studies.size - 1)
        es += ", "
      end
    }
    es += "}"
    #file.puts es
    file.puts "@attribute año {2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009}"
    file.puts "@attribute mes {Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre}"
    file.puts "@attribute sexo {hombre, mujer}"
    file.puts "@attribute edad {mayor_25, menor_25}"
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

    acv = "@attribute estudios {"
    studies.each_with_index.map { |e, i|
      acv += e
      puts "#{e}"
      if (i != studies.size - 1)
        acv += ", "
      end
    }
    acv += "}"
    file.puts acv

    file.puts "@attribute paro {si, no}"

    file.puts "\n\n"
    file.puts "@data\n"

    ac = 0;

    @content.map { |row|

      content = ""

      # Mujeres
      puts "aa   #{get_total_population}"

      row.activities.each_with_index.map { |act, i|
        row.percent_age.each_with_index.map { |age, j|
          row.percent_studies.each_with_index.map { |studie, k|
            puts "hay #{act.women * age * studie} de mujeres en la actividad #{@activities[i]} con edad #{@ages[j]} y estudios #{@studies[k]}"
            ac += act.women * age * studie
            for cn in 0..(act.women * age * studie).to_i / 100 do
              file.puts "#{row.year},mujer,#{@ages[j]},#{@activities[i]},#{@studies[k]},si"
            end
          }
        }
      }

      # hombres
      row.activities.each_with_index.map { |act, i|
        row.percent_age.each_with_index.map { |age, j|
          row.percent_studies.each_with_index.map { |studie, k|
            puts "hay #{act.men * age * studie} de hombres en la actividad #{@activities[i]} con edad #{@ages[j]} y estudios #{@studies[k]}"
            ac += act.men * age * studie
            for cn in 0..(act.men * age * studie).to_i / 100 do
              file.puts "#{row.year},hombre,#{@ages[j]},#{@activities[i]},#{@studies[k]},si"
            end
          }
        }
      }

      file.puts content
    }
    puts "Hay #{ac/10} personas"

  end

end

def parse_activities line, full
  line = line.split(',')
  line.map { |e|
    full.activities << e.delete("\"").split(' ').join('_')
  }
end

def parse_studies line, full
  line = line.split(',')
  line.map { |e|
    full.studies << e.delete("\"").split(' ').join('_')
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
  # Población total, mujeres / hombres
  total_population = Population.new line[2], line[3]
  index = 4
  activities = []

  # Actividades, cantidad de gente empleada en esa actividad
  full.activities.each_with_index.map { |e, i|
    #puts "#{e} #{line[index + i * 2]} #{line[index + i * 2 + 1]}"
    pop = Population.new line[index + i * 2], line[index + i * 2 + 1]
    activities << pop
  }

  index = 4 + full.activities.size * 2
  studies = []

  # Nivel de estudios, cantidad de gente según estudios
  full.studies.each_with_index.map { |e, i|
    #puts "#{i + index} #{line[i + index]} #{e}"
    studies << line[i + index]
  }
  index += full.studies.size

  # Edad
  #puts "#{line[index]} #{line[index + 1]}"
  age = []
  age << line[index]
  age << line[index + 1]

  # calcula los porcentajes de personas mayores y menores de 25 años
  percent_ages = []
  percent_ages << age[0].to_f / total_population.get_total.to_f
  percent_ages << age[1].to_f / total_population.get_total.to_f

  # Calcula los porcentajes de estudio
  percent_studies = []
  percent_studies << studies[0].to_f / total_population.get_total.to_f
  percent_studies << studies[1].to_f / total_population.get_total.to_f
  percent_studies << studies[2].to_f / total_population.get_total.to_f
  percent_studies << studies[3].to_f / total_population.get_total.to_f
  percent_studies << studies[4].to_f / total_population.get_total.to_f

  row = Row.new total_population, activities, percent_studies, percent_ages, date
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
    data.ages.delete("\n")

    data.create_file

  else
    puts "No se pudo abrir el archivo"
  end
end
