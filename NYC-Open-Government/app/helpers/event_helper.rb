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

  def audit_categories(params)
    attributes_hash = params[:categories_attributes]
    if attributes_hash 
      array = []
      attributes_hash.each do |k, v|
        v.each do |attr, value|  # ex. value "Local Law"
          array << value
        end
      end
      objects = []
      array.each do |name|
        found = Category.find_by_name(name)
        if found
          objects << found
        else
          objects << Category.create(:name => name)
        end
      end
      objects
    else
      []
    end
  end

end
