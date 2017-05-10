class Date
  attr_reader :year, :month
  @year
  @month
  def initialize (y, m)
    @year = y
    @month = m
  end
end

class Studies
  @studies = []
  def initialize (studies)
    @studies = studies
  end

  def get_study_at (n)
    @studies[n]
  end

end

class Population
  attr_accessor :woman, :men
  @women
  @men
  def initialize w, m
    @woman = w
    @men = m
  end

  def get_total
    @woman + @men
  end
end

class Age
  attr_accessor :greater_25, :lower_25
  @greater_25
  @lower_25
  def initialize l, g
    @lower_25 = l
    @greater_25 = g
  end
end

class Row
  attr_accessor :date, :total, :total_population, :activities, :studies
  @date
  @total_population
  @activities = []
  @studies = []
end


class FullData
  attr_accessor :content, :activities, :studies, :ages

  def initialize
    @activities = []
    @studies = []
    @ages = []
  end
  @activities
  @studies
  @ages

  @translator
  @content = []
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
  row.total_population = Population.new line[2], line[3]
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
  else
    puts "No se pudo abrir el archivo"
  end
end
