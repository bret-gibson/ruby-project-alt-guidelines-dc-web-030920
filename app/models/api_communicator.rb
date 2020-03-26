def spell_check
    key = "99beba5ebb004eca93e0e6ac47da4bf0"
    uri = 'https://api.cognitive.microsoft.com'
    path = '/bing/v5.0/spellcheck'
    params = 'mkt=en-us&mode=proof'
    uri = URI(uri + path)
    uri.query = URI.encode_www_form({
        # Request parameters
     'text' => gets.chomp.gsub(" ","+")
     })
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = "application/x-www-form-urlencoded"
    request['Ocp-Apim-Subscription-Key'] = key

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    # binding.pry
    result = JSON.parse(response)
    puts result
end