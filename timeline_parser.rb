require 'csv'
require 'awesome_print'

class CSVParser
  attr_accessor :output
  attr_reader :column_names, :data_rows

  def initialize(path_to_csv)
    timeline_csv = CSV.read(path_to_csv)
    @column_names = timeline_csv[0] # [Timestamp, Date, ...]
    @data_rows = timeline_csv[1..-1]
    @output = []
  end

  def parse
    data_rows.each do |row|
      hash = {}  
      row.each_with_index do |attribute, i|
        if i < (row.length-2)
          hash[column_names[i]] = attribute
        end
      end
      output << hash
    end
    output
  end
end

my_parser = CSVParser.new('Timeline.csv')
print my_parser.parse


