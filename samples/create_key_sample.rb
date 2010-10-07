require 'hmac-sha2'  
require 'base64'
require 'cgi'
require 'date'
load '../keys.rb' 

expected_signature="Rfo1hgMnp1urA2CDpi1pxmP6Mu8%2FxgwU0hd2ZEsiUXY%3D"
string_to_sign = "GET
ecs.amazonaws.com
/onca/xml
AWSAccessKeyId=AKIAJ5CS7UGGUIDUBLXA&ItemId=0500330220&Operation=ItemLookup&ResponseGroup=ItemAttributes%2CImages%2CEditorialReview&Service=AWSECommerceService%20%20%20&Timestamp=2010-10-07T18%3A38%3A45.000Z"

digest = HMAC::SHA256.new(SECRET) << string_to_sign 
signature = CGI.escape(Base64.encode64(digest.digest()).strip())       

puts "expected=  " + expected_signature
puts "generated= " + signature
  
# how we format dates to create the timestamp
d = DateTime.now
puts d.strftime('%FT%T.000Z')