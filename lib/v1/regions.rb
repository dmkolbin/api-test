module Regions
  def main_countries
    [
      {id: 24462, name: 'Россия'},
      {id: 24463, name: 'Украина'},
      {id: 10000, name: 'Беларусь'},
      {id: 10003, name: 'Казахстан'}
    ]
  end

  class NewApiRegions
    def city_by_ip
      url = "#{new_api_url}/cities/current"
      res = { method: :get, url: url }.request.parse_body['city']
      {
        city_id: res['id'],
        city_name: res['name'],
        province_id: res['province']['id'],
        province_name: res['province']['name'],
        country_id: res['province']['country']['id'],
        country_name: res['province']['country']['name']
      }
    end

    def countries
      url = "#{new_api_url}/countries"
      { method: :get, url: url }.request
    end

    def provinces(country_id)
      url = url_collector("#{new_api_url}/provinces", country_id: country_id)
      { method: :get, url: url }.request
    end

    def cities(province_id)
      url = url_collector("#{new_api_url}/cities", province_id: province_id)
      { method: :get, url: url }.request
    end

    def countries_list
      countries.parse_body['countries']
    end

    def provinces_list(country_id)
      provinces(country_id).parse_body['provinces']
    end

    def cities_list(province_id)
      cities(province_id).parse_body['cities']
    end

    def random_city
      path = []
      country = main_countries.sample
      path << country[:name]
      province = provinces_list(country[:id]).sample
      path << province['name']
      city = cities_list(province['id']).sample
      path << city['name']
      { id: city['id'], name: city['name'], path: path }
    end
  end
end