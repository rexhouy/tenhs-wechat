# -*- coding: utf-8 -*-
require "grape"
require "./verification"

module Web
        class API < Grape::API

                # Developer verification
                get "verification" do
                        content_type "text/plain"
                        puts params[:signature]
                        Verification.new.verify(params[:timestamp], params[:nonce], params[:echostr], params[:signature])
                end

                # rescue from errors
                # rescue_from :all do |e|
                #         Rack::Response.new([ "We have encounted some error!" ], 500, { "Content-type" => "text/error" }).finish
                # end

                # 404
                # route :any, '*path' do
                #         content_type :txt, "text/plain"
                #         body false # return nothing
                # end

        end
end
