require 'wor/requests/base'
require 'wor/requests/request_error'
require 'wor/requests/version'
require 'logger'

class GithubService < Wor::Requests::Base
  def repositories_with_log_without_block(username)
    get(
      attempting_to: "get repositories of #{username}",
      path: "/users/#{username}/repos"
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def repositories_with_log_with_block(username)
    get(
      attempting_to: "get repositories of #{username}",
      path: "/users/#{username}/repos"
    ) { |response| JSON.parse(response.body)['repos'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def repositories_without_log_without_block(username)
    get(
      path: "/users/#{username}/repos"
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def repositories_without_log_with_block(username)
    get(
      path: "/users/#{username}/repos"
    ) { |response| JSON.parse(response.body)['repos'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def repositories_without_rescue(username)
    get(
      path: "/users/#{username}/repos"
    )
  end

  protected

  def base_url
    'https://api.github.com'
  end
end
