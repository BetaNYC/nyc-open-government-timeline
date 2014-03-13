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
          "headline" => "NYC’s Open Data & Government Timeline",
          "type" => "default",
          "text" => 'Welcome to NYC’s open government timeline. This site will walk you historical events that have made NYC one of the most open and connected cities on this planet. The site is broken down into five categories: community, events, legislative actions and executive orders, policy changes, and tools. You can improve this site via <a target="_blank" href="https://github.com/BetaNYC/nyc-open-government-timeline">GitHub</a> or add an event via this <a target="_blank" href="https://docs.google.com/a/betanyc.us/forms/d/16SQjfvdVEGo8MWv0vLYDVp31opJ5U54VZbcAERfCoQw/viewform">form</a>.',
          "asset" => {
              "media" => "/app/img/banner.png",
              "caption" => "BetaNYC's Open Data & Government Timeline"
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