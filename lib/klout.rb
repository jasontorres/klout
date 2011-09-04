require 'uri'
require 'net/http'
require 'rubygems'
require 'json'

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
  VERSION = '0.1.1'
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

    def klout_score(usernames)
      request_uri = "#{BASE_URI}/klout.json?users=#{usernames}&key=#{@@api_key}"
      return request(request_uri)
    end
    
    def show_user(usernames)
      request_uri = "#{BASE_URI}/users/show.json?users=#{usernames}&key=#{@@api_key}"
      return request(request_uri)
    end
    
    def topics(usernames)
      request_uri = "#{BASE_URI}/users/topics.json?users=#{usernames}&key=#{@@api_key}"
      return request(request_uri)
    end
    
    def influenced_by(usernames)
      request_uri = "#{BASE_URI}/soi/influenced_by.json?users=#{usernames}&key=#{@@api_key}"
      return request(request_uri)
    end
    
    def influencer_of(usernames)
      request_uri = "#{BASE_URI}/soi/influencer_of.json?users=#{usernames}&key=#{@@api_key}"
      return request(request_uri)
    end
    
    def request(request_uri)
      begin
        url = URI.parse(request_uri)
        response = JSON.parse(Net::HTTP.get(url))
        if response["status"] == 200
          response
        else
          nil
        end
      rescue => error
        raise error
      end
    end
  end
end
