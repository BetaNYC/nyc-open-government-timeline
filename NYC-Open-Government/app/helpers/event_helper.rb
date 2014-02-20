module EventHelper

  def clean_params(params)
    new_params = {}
    params.each {|k, v| k != "categories" ? new_params[k] = v : nil} 
    new_params
  end

  def categories(event)
    event.categories.collect{|cat| cat.name}.join(', ')
  end

end
