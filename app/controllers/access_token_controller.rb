require "./app/models/access_token"
require "./app/config"
require "net/http"
require "json"

class AccessTokenController

        def get
                token = AccessToken.first
                return update(AccessToken.new) if token.nil?
                return update(token) if expired?(token)
                token
        end

        def update(old_token)
                return get if old_token.nil?
                token = retrieve_token
                old_token.token = token["access_token"]
                old_token.expires_in = token["expires_in"]
                old_token.updated_at = Time.now
                old_token.save
                old_token
        end

        private

        def retrieve_token
                resp = send_request
                JSON.parse resp.body
        end

        def send_request
                host = Config::ACCESS_TOKEN["host"]
                port = Config::ACCESS_TOKEN["port"]
                path = Config::ACCESS_TOKEN["path"]
                http = Net::HTTP.new(host, port)
                http.use_ssl = true
                http.set_debug_output($stdout)
                req = Net::HTTP::Post.new(path)
                http.request(req)
        end

        def expired?(token)
                token.updated_at + token.expires_in.seconds < Time.now
        end

end
