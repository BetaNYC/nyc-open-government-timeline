# timeline.rb

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
              "media" => "http://yourdomain_or_socialmedialink_goes_here.jpg",
              "credit" => "Credit Name Goes Here",
              "caption" => "Caption text goes here"
          },
          "date" => [
              
          ]
      }
    }
  end

  def add_events(events)
    events.each do |event|
      eventJSON = {
        "startDate" => "#{event.date}",
        "endDate" => "#{event.date}",
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