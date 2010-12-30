require 'lib/klout'

Klout.api_key = 'YOUR_KEY'
p Klout.score('jsgoecke')
p Klout.score([ 'jsgoecke', 'chrismatthieu', 'johnnydiggz' ])

p Klout.profile('jsgoecke')
p Klout.profile([ 'jsgoecke', 'chrismatthieu', 'johnnydiggz' ])