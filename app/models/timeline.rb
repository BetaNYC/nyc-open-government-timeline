# timeline.rb

require 'date'

class Timeline

  attr_accessor :attribute_hash

  def initialize(args)
    name = args[:name]
    intro = args[:intro]

    @attribute_hash = {
      "timeline" =>
      {
          "headline" => "#{name}",
          "type" => "default",
          "text" => "<p>#{intro}</p>",
          "asset" => {
              "media" => "/app/img/logo.png",
              "caption" => "BetaNYC's logo"
          },
          "date" => [
              
          ]
      }
    }
  end

  def add_events(events)
    events.each do |event|
      #This is for putting date into a format the timeline.js expects
      if event.date.nil? 
        next 
      end

      date = event.date.to_s.split(" ")
      reformatted_date = date[0].split("-").join(",")

      eventJSON = {
        "startDate" => "#{reformatted_date}",
        "endDate" => "#{reformatted_date}",
        "headline" => "#{event.name}",
        "text" => "<p>#{event.description}</p><br><p style='font-size: .85em'>Sub-category: #{event.sub_category}</p>",
        "tag" => "#{event.categories.first.name}",
        "classname" => "",
        "asset" => {
            "media" => "#{event.url}",
            "thumbnail" => "",
            "credit" => "",
            "caption" => ""
        }
      }
      @attribute_hash["timeline"]["date"] << eventJSON
    end
  end

end