$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'klout'
require 'json'

Klout.api_key = 'YOUR_API_KEY'
p Klout.score('jsgoecke')
p Klout.score([ 'jsgoecke', 'chrismatthieu', 'johnnydiggz' ])

p Klout.profile('jsgoecke')
p Klout.profile([ 'jsgoecke', 'chrismatthieu', 'johnnydiggz' ])