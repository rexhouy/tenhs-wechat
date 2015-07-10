require "digest/sha1"
class Verification
        def verify(timestamp, nonce, echostr, signature)
                return echostr if check_signature({timestamp: timestamp, nonce: nonce, echostr: echostr}, signature)
                ""
        end

        def sign(params)
                str = params.sort.reduce("") do | memo, (k, v) |
                        memo << v
                end
                Digest::SHA1.hexdigest(str)
        end

        private

        # Use signature to verify if the params are correct.
        def check_signature(params, signature)
                str = params.sort.reduce("") do | memo, (k, v) |
                        memo << v
                end
                Digest::SHA1.hexdigest(str).eql? signature
        end

end
