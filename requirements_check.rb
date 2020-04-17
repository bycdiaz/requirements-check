require 'csv'

def read_csv
  student_info = {}

  CSV.foreach('data/STU-Student Transcript-ALL-BIOMED_201925.csv', headers: true) do |header|

    if !(student_info.include?(header["Univ Id"]))
      student_info[header["Univ Id"]] = {}

      student_info[header["Univ Id"]]["Admit Year"] = header["Term Code Admit"]
      student_info[header["Univ Id"]]["Name"] = header["Student"]

      if header["Last Name"].start_with?(/[A-F]/)
        student_info[header["Univ Id"]]["Advisor"] = "Laurie Lenz"
      elsif header["Last Name"].start_with?(/[G-K]/)
        student_info[header["Univ Id"]]["Advisor"] = "Caryn Glaser"
      elsif header["Last Name"].start_with?(/[L-Q]/)
        student_info[header["Univ Id"]]["Advisor"] = "Carlos Diaz"
      elsif header["Last Name"].start_with?(/[R-Z]/)
        student_info[header["Univ Id"]]["Advisor"] = "Elise Bryers"
      end

      # Creates Courses hash.
      student_info[header["Univ Id"]]["Courses"] = {}

      # Adds 1st course.
      if !(student_info[header["Univ Id"]]["Courses"].include?(header["Crse"]))
        student_info[header["Univ Id"]]["Courses"][header["Crse"]] = {}
        student_info[header["Univ Id"]]["Courses"][header["Crse"]] = header["Grade"]
      end
      
    end

    # Adds all courses
    if !(student_info[header["Univ Id"]]["Courses"].include?(header["Crse"]))
      student_info[header["Univ Id"]]["Courses"][header["Crse"]] = {}

      # Identifies Transfer courses
      if header["GPA Type Ind"] == "T"
        student_info[header["Univ Id"]]["Courses"][header["Crse"]] = "Transfer"
      else
        student_info[header["Univ Id"]]["Courses"][header["Crse"]] = header["Grade"]
      end
      
    end

  end
  student_info
end

puts read_csv["11672923"]
