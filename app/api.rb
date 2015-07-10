# -*- coding: utf-8 -*-
require "grape"
require "./app/controllers/verification_controller"
require "./app/controllers/access_token_controller"
require "./config/application"

Application.new

module Web

        class API < Grape::API

                default_format :json

                # Developer verification
                get "verification" do
                        content_type "text/plain"
                        Verification.new.verify(params[:timestamp], params[:nonce], params[:echostr], params[:signature])
                end

                # Access access token
                resource :access_token do
                        content_type :json, "application/json"
                        get do
                                AccessTokenController.new.get
                        end
                        post do
                                AccessTokenController.new.update
                        end
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
