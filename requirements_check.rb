require 'fileutils'
require 'csv'



def collect_ids
  student_info = Hash.new

  CSV.foreach('data/STU-Student Transcript-ALL-BIOMED_201925.csv', headers: true) do |header|
    advisors = ["Laurie Lenz", "Caryn Glaser", "Carlos Diaz", "Elise Bryers"]

    if !(student_info.include?(header["Univ Id"]))
      student_info[header["Univ Id"]] = Hash.new
      student_info[header["Univ Id"]]["Admit Year"] = header["Term Code Admit"]
      student_info[header["Univ Id"]]["Name"] = header["Student"]

      if header["Last Name"].start_with?(/[ABCDEF]/)
        student_info[header["Univ Id"]]["Advisor"] = advisors[0]
      elsif header["Last Name"].start_with?(/[GHIJK]/)
        student_info[header["Univ Id"]]["Advisor"] = advisors[1]
      elsif header["Last Name"].start_with?(/[LMNOPQ]/)
        student_info[header["Univ Id"]]["Advisor"] = advisors[2]
      elsif header["Last Name"].start_with?(/[RSTUVWXYZ]/)
        student_info[header["Univ Id"]]["Advisor"] = advisors[3]
      end
    end
  end
  student_info
end

print collect_ids
