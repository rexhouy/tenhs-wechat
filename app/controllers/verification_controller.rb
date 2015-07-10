require "digest/sha1"
require 'erb'
require 'yaml'
require "./app/config"

class Verification

        def verify(timestamp, nonce, echostr, signature)
                return echostr if check_signature([timestamp, nonce, Config::APP["token"]], signature)
                ""
        end

        def sign(params)
                str = params.sort.reduce("") do | memo, v |
                        memo << v
                end
                Digest::SHA1.hexdigest(str)
        end

        private

        # Use signature to verify if the params are correct.
        def check_signature(params, signature)
                str = params.sort.reduce("") do | memo, v |
                        memo << v
                end
                Digest::SHA1.hexdigest(str).eql? signature
        end

end
