def composition people, info_studies, info_sector
  new_people = []
  new_people_2 = []
  new_people_3 = []
  # Nivel de estudios
  people.map { |e|
    if (e[2] == "hombre")
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Analfabeto"][0],"Analfabetos"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Primaria"][0],"Primaria"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Secundaria"][0],"Secundaria"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["FP"][0],"FP"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Universidad"][0],"Universitario"]
    elsif (e[2] == "mujer")
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Analfabeto"][1],"Analfabetos"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Primaria"][1],"Primaria"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Secundaria"][1],"Secundaria"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["FP"][1],"FP"]
      new_people << [e[0],e[1],e[2],e[3],e[4],e[5] * info_studies["Universidad"][1],"Universitario"]
    else
      puts "Hay un fuerte problema"
    end
  }

  # Campo de actuación
  new_people.map { |e|
    for i in 0..info_sector[e[4]].size() - 1
      new_people_2 << [e[0],e[1],e[2],e[3],info_sector[e[4]][i],e[6],e[5] / info_sector[e[4]].size()]
    end
  }

  filename = "values.arff"
  file = File.open(filename, 'w')

  # Multiplicar
  ac = 0
  new_people_2.map { |e|
    for i in 0..(e[-1]*50).to_i
      puts ac
      file.puts "#{e[0]},#{e[1]},#{e[2]},#{e[3]},#{e[4]},#{e[5]},no"
      ac += 1
    end
  }

  new_people_3

end

def parse_sectors_line sector, info_sector, info_studies
  for i in 0...5
    info_sector[sector[i][0].to_s] = []
    for j in 1..sector[i].size() -1
      #puts "al sector #{sector[i][0]} le añado #{sector[i][j]}"
      info_sector[sector[i][0].to_s] << sector[i][j].split(' ').join('_')
      puts "#{sector[i][j].split(' ').join('_')}"
    end
    puts info_sector[i]
  end

  for i in 5...10
    info_studies[sector[i][0].to_s] = []
    #puts "el estudio es #{sector[i][0]}"
    for j in 1..2
      info_studies[sector[i][0].to_s] << sector[i][j].to_f
    end
  end
end

def parse_empleo_line matrix, people
activities = ["Agricultura","Industria","Construcción","Servicios","No Clasificable"]

  year = 0;

  sv_year = ""
  sv_month = ""
  sv_sex = ""
  sv_age = ""

  while (year < matrix.size()) do
    puts "Encontré #{matrix[year][0]}"
    sv_year = matrix[year][0]
    year += 1
    # Buscando meses
    while (year < matrix.size() and matrix[year][1] != "") do
      puts "Encontré en #{matrix[year][1]}"
      sv_month = matrix[year][1]
      year+= 1
      #Sexo
      while (year < matrix.size() and matrix[year][2] != "") do
        puts "El sexo es #{matrix[year][2]}"
        sv_sex = matrix[year][2]
        # Menores de 25
        puts "Los menores de 25"
        for i in 0..4 do
          sv_age = "menor_25"
          puts "En la actividad #{i} #{matrix[year][4 + i]}"
          people << [sv_year,sv_month,sv_sex,sv_age,activities[i],matrix[year][4 + i].to_f]
        end
        # Mayores de 25
        puts "Los mayores de 25"
        sv_age = "mayor_25"
        for i in 0..4 do
          puts "En la actividad #{i} #{matrix[year][10 + i]}"
          people << [sv_year,sv_month,sv_sex,sv_age,activities[i],matrix[year][4 + i].to_f]
        end

        year += 1
      end
    end
    year += 1
    puts "NUEVO AÑO"

  end

end

def parse_sectores_line line, full
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
  filename_1 = "Empleo.csv"
  filename_2 = "Sectores.csv"

  people = []
  info_sector = {}
  info_studies = {}

  if (File.file?(filename_1))
    puts "Archivo abierto"
    file_1 = File.open(filename_1, 'r')
    file_1.readline
    matrix = []
    while !file_1.eof?
       matrix << file_1.readline.split(",")
    end
    parse_empleo_line matrix, people
  else
    puts "No se pudo abrir el archivo 1"
  end

  if (File.file?(filename_2))
    file_2 = File.open(filename_2, 'r')
    sectors = []
    while !file_2.eof?
      sectors << file_2.readline.split(",")
    end
    parse_sectors_line sectors, info_sector, info_studies
  else
    puts "No se pudo abrir el archivo 2"
  end

  people= composition people, info_studies, info_sector
end
