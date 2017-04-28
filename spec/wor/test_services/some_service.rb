require 'wor/requests/base'
require 'wor/requests/request_error'
require 'wor/requests/version'
require 'logger'

class SomeService < Wor::Requests::Base
  def get_with_log_without_block
    get(
      attempting_to: "attempting_to get mypath",
      path: "/mypath"
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_with_log_with_block
    get(
      attempting_to: "attempting_to get mypath",
      path: "/mypath"
    ) { |response| JSON.parse(response.body)['array'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_log_without_block
    get(
      path: "/mypath"
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_log_with_block
    get(
      path: "/mypath"
    ) { |response| JSON.parse(response.body)['array'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_rescue
    get(
      path: "/mypath"
    )
  end

  protected

  def base_url
    'https://baseurl.com'
  end
end
