require 'wor/requests/base'
require 'wor/requests/request_error'
require 'wor/requests/version'
require 'logger'

class SomeService < Wor::Requests::Base
  def get_with_log_without_block
    get(
      attempting_to: 'attempting_to get mypath',
      path: '/mypath'
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_with_log_with_block
    get(
      attempting_to: 'attempting_to get mypath',
      path: '/mypath'
    ) { |response| JSON.parse(response.body)['array'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_log_without_block
    get(
      path: '/mypath'
    )
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_log_with_block
    get(
      path: '/mypath'
    ) { |response| JSON.parse(response.body)['array'].reduce('', :+) }
  rescue Wor::Requests::RequestError => e
    e
  end

  def get_without_rescue
    get(
      path: '/mypath'
    )
  end

  VALID_HTTP_VERBS = %i(get post patch put delete).freeze
  VALID_HTTP_VERBS.each do |http_verb|
    method = "#{http_verb}_with_unpermitted_params"
    define_method(method) do |opts = {}, &block|
      # this fails because of using get with invalid parameter
      self.send(
        http_verb,
        body: { prop: 'value' },
        some_unpermitted: 'hello',
        other_unpermitted: 'world',
        path: '/mypath'
      )
    end

    method_with_rescue = "#{http_verb}_with_unpermitted_params_with_rescue"
    define_method(method_with_rescue) do |opts = {}, &block|
      begin
        # this fails because of using get with invalid parameter
        self.send(method)
      rescue Wor::Requests::InvalidOptionsError => e
        e
      end
    end
  end

  protected

  def base_url
    'https://baseurl.com'
  end
end
