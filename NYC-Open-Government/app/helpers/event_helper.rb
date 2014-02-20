module EventHelper

  def clean_params(params)
    new_params = {}
    params.each do |k, v| 
      unless k == "categories_attributes"
        new_params[k] = v
      end
    end
    new_params
  end

  def categories(event)
    event.categories.collect{|cat| cat.name}.join(', ')
  end

end
