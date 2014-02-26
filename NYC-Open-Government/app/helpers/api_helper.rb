# api_helper.rb

module ApiHelper 
  def query_by_name(all_resources, params_name)
    return_val = ""
    all_resources.each do |resource|
      if resource.name.downcase == clean_query(params_name)
        return_val = resource
      end
    end
    return_val
  end

  def clean_query(params_query)
    params_query.gsub('%20', ' ').downcase
  end
end