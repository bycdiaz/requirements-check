# require 'fileutils'
require 'csv'

def collect_ids
  student_info = Hash.new

  CSV.foreach('data/STU-Student Transcript-ALL-BIOMED_201925.csv', headers: true) do |header|

    if !(student_info.include?(header["Univ Id"]))
      student_info[header["Univ Id"]] = Hash.new

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

      # this needs to be in a second run of the CSV
      student_info["Courses"] = Hash.new
      student_info["Courses"][header["Crse"]] = header["Grade"]
    end
  end
  student_info
end

print collect_ids
