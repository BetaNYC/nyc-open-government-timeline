require 'csv'

class Parser
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

  def add_to_database
    parse.each do |hash|
      Event.create(
        :date => hash["Date"],
        :name => hash["Name"],
        :url => hash["URL"],
        :category => hash["Type of Event"],
        :description => hash["Description"]
      )
    end
  end

end
