# frozen_string_literal: true

require 'csv'

def read_csv
  student_info = {}

  CSV.foreach('data/STU-Student Transcript-ALL-BIOMED_201925.csv', headers: true) do |header|
    unless student_info.include?(header['Univ Id'])
      student_info[header['Univ Id']] = {}

      student_info[header['Univ Id']]['Admit Year'] = header['Term Code Admit']
      student_info[header['Univ Id']]['Name'] = header['Student']

      if header['Last Name'].start_with?(/[A-F]/)
        student_info[header['Univ Id']]['advisor'] = 'Laurie Lenz'
      elsif header['Last Name'].start_with?(/[G-K]/)
        student_info[header['Univ Id']]['advisor'] = 'Caryn Glaser'
      elsif header['Last Name'].start_with?(/[L-Q]/)
        student_info[header['Univ Id']]['advisor'] = 'Carlos Diaz'
      elsif header['Last Name'].start_with?(/[R-Z]/)
        student_info[header['Univ Id']]['advisor'] = 'Elise Bryers'
      end

      # Creates Courses hash.
      student_info[header['Univ Id']]['courses'] = {}

      # Adds 1st course.
      unless student_info[header['Univ Id']]['courses'].include?(header['Crse'])

        if header['Crse'] == 'N/A'
        else
          student_info[header['Univ Id']]['courses'][header['Crse']] = {}
          if header['GPA Type Ind'] == 'T' # Identifies Transfer courses
            student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = {}
            student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = 'transfer'

          else
            student_info[header['Univ Id']]['courses'][header['Crse']] = {}
            student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = {}
            student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = header['Grade']
          end
          student_info[header['Univ Id']]['courses'][header['Crse']]['credits'] = header['Credit Hrs'].to_f
        end
      end

    end

    # Adds all courses
    unless student_info[header['Univ Id']]['courses'].include?(header['Crse'])

      if header['Crse'] == 'N/A'
      else
        student_info[header['Univ Id']]['courses'][header['Crse']] = {}
        student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = {}

        if header['GPA Type Ind'] == 'T' # Identifies Transfer courses
          student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = {}
          student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = 'transfer'
        else
          student_info[header['Univ Id']]['courses'][header['Crse']]['grade'] = header['Grade']
        end
        student_info[header['Univ Id']]['courses'][header['Crse']]['credits'] = header['Credit Hrs'].to_f
      end

    end
  end
  student_info
end

puts read_csv['11672923']
