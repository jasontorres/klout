require 'rubygems'
require 'json'
require 'open-uri'
require 'net/http'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

=begin rdoc

Klout measures influence on topics across the social web to find the people the world listens to

See http://klout.com for more information about their service

Usage:

Klout.api_key = ""
Klout.score('jasontorres')

=end


class Klout
  VERSION = '0.0.1'
  BASE_URI = 'http://api.klout.com/1'
  
  class << self
    @@base_host = "klout.com"
    
    @@api_key = ""

    def api_key=(api)
      @@api_key = api
    end
    
    def api_key
      @@api_key
    end

    def score(usernames)
      request_uri = "#{BASE_URI}/klout.json?key=#{ @@api_key }&users=#{ join_usernames(usernames) }"
      return request(request_uri)
    end
    
    def profile(usernames)
      request_uri = "#{BASE_URI}/users/show.json?key=#{ @@api_key }&users=#{ join_usernames(usernames) }"
      return request(request_uri)
    end
    
    private
    
    def join_usernames(usernames)
      if usernames.instance_of? Array
        usernames.join(',') 
      else
        usernames
      end
    end
    
    def request(request_uri)
      url = URI.parse(request_uri)
      response = Net::HTTP.start(url.host, url.port) { |http|
        http.get(url.request_uri)
      }
      
      case response
        when Net::HTTPSuccess
          if response.body
            begin 
              JSON.parse(response.body)
            rescue Exception => e
              puts e.backtrace
              false
            end
          end
        else
          response.error!
      end
    end
  end
end