class DiscourseSsoController < ApplicationController
  def sso
    secret = ENV["DISCOURSE_SECRET"]
    sso = Discourse::SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email
    sso.name = current_user.name
    # sso.username = current_user.nickname
    sso.external_id = current_user.id
    sso.sso_secret = secret

    redirect_to sso.to_url("#{ENV['DISCOURSE_URL']}/session/sso_login")
  end
end
