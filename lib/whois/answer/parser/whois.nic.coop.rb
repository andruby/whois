#
# = Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
#
# Category::    Net
# Package::     Whois
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


require 'whois/answer/parser/base'


module Whois
  class Answer
    class Parser

      #
      # = whois.nic.coop parser
      #
      # Parser for the whois.nic.coop server.
      #
      # NOTE: This parser is just a stub and provides only a few basic methods
      # to check for domain availability and get domain status.
      # Please consider to contribute implementing missing methods.
      # See WhoisNicIt parser for an explanation of all available methods
      # and examples.
      #
      class WhoisNicCoop < Base

        property_supported :status do
          @status ||= if content.to_s =~ /Status:\s+(.*)\r\n/
            $1.downcase.to_sym
          end
        end

        property_supported :available? do
          @available ||= !!(content.to_s =~ /No domain records were found to match/)
        end

        property_supported :registered? do
          !available?
        end


        property_supported :created_on do
          @created_on ||= if content.to_s =~ /Created:\s+(.*)\r\n/
            Time.parse($1)
          end
        end

        property_supported :updated_on do
          @updated_on ||= if content.to_s =~ /Last updated:\s+(.*)\r\n/
            Time.parse($1)
          end
        end

        property_supported :expires_on do
          @expires_on ||= if content.to_s =~ /Expiry Date:\s+(.*)\r\n/
            Time.parse($1)
          end
        end

      end
      
    end
  end
end  