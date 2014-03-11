require 'csv'
require 'date'

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
      array = hash["Date"].split("/")
      date = [array[1], array[0], array[2]].join("-")
      # if hash["Name"] == "NYC Chief Information Innovation Officer appointed - Rahul N. Merchant"
        # debugger
      event_object = Event.create(
        :date => date,
        :name => hash["Name"],
        :url => hash["URL"],
        :description => hash["Description"],
        :sub_category => hash["Type of Event"]
      )
      category_name = hash["Parent"]  #grabs category string name from csv
      category = Category.find_by_name(category_name) #find the category object with name = string name
      if category   #if that category exists in the db already
        event_object.categories << category    # add existing category to the event objects categories    
      else      #if it doesn't exist
        category_object = Category.create(:name => category_name)   #make a new category, with name equal to cat string name
        event_object.categories << category_object    #add that new category to the event objects categories
      end
      event_object.save
    end
  end

end
