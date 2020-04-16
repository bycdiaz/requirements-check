require 'fileutils'
require 'csv'



def collect_ids
  student_info = Hash.new

  CSV.foreach('data/STU-Student Transcript-ALL-BIOMED_201925.csv', headers: true) do |header|
    # advisors = ["Carlos Diaz", "Homer Simpson"]

    if !(student_info.include?(header["Univ Id"]))
      student_info[header["Univ Id"]] = Hash.new
      student_info[header["Univ Id"]]["Admit Year"] = header["Term Code Admit"]
      student_info[header["Univ Id"]]["Name"] = header["Student"]

      # if header["Last Name"].start_with?("C")
      #   student_info[header["Univ Id"]]["Advisor"] = advisors[0]
      # end
    end
  end
  student_info
end

print collect_ids
