class Date
  attr_reader :year, :month
  def initialize (y, m)
    @year = y.to_i
    @month = m
  end
end


class Population
  attr_accessor :women, :men
  def initialize m, w
    @women = w.to_i
    @men = m.to_i
  end

  def get_total
    @women + @men
  end
end

class Age
  attr_accessor :greater_25, :lower_25
  def initialize l, g
    @lower_25 = l.to_i
    @greater_25 = g.to_i
  end
end

class Row
  attr_accessor :date, :total, :total_population, :activities, :studies
  def initialize
    @activities = []
    @studies = []
  end
  @date
  @total_population
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
end

def parse_activities line, full
  line = line.split(',')
  line.map { |e|
    full.activities << e
  }
end

def parse_studies line, full
  line = line.split(',')
  line.map { |e|
    full.studies << e
  }
end

def parse_ages line, full
  line = line.split(',')
  line.map { |e|
    full.ages << e
  }
end

def parse_regular_line line, full
  line = line.split(',')
  row = Row.new
  row.date = Date.new line[0], line[1]
  # Población total
  row.total_population = Population.new line[2], line[3]

  index = 4
  # Actividades
  full.activities.each_with_index.map { |e, i|
    #puts "#{e} #{line[index + i * 2]} #{line[index + i * 2 + 1]}"
    pop = Population.new line[index + i * 2], line[index + i * 2 + 1]
    row.activities << pop
  }

  index = 4 + full.activities.size * 2

  # Nivel de estudios
  full.studies.each_with_index.map { |e, i|
    #puts "#{i + index} #{line[i + index]} #{e}"
    row.studies << line[i]
  }

  index += full.studies.size

  # Edad
  #puts "#{line[index]}"
  age = Age.new line[index], line[index + 1]

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

    data.get_total_population

  else
    puts "No se pudo abrir el archivo"
  end
end
