class JoobleService
  attr_reader :argument_hash

  def initialize(keywords, location, radius, salary, page)
    @argument_hash = { keywords: keywords,
                       location: location,
                       radius: radius,
                       salary: salary,
                       page: page
                      }
  end

  def parse_listings_data
    parsed_response(post_request)
  end

  def post_request
    conn.post do |req|
      req.body = arguments.to_json()
    end
  end

  def arguments
    final_arguments = {}
    argument_hash.each do |key, value|
      if value != nil
        final_arguments[key] = value
      end
    end
    return final_arguments
  end

  def conn
    Faraday.new(url: "https://us.jooble.org/api/#{ENV["JOOBLE_API_KEY"]}") do |f|
      f.adapter Faraday.default_adapter
      f.headers = arguments
    end
  end

  def parsed_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
