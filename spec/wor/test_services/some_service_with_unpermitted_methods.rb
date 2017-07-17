require 'wor/requests/base'
require 'wor/requests/request_error'
require 'wor/requests/version'
require 'logger'

class SomeServiceWithUnpermittedMethods < SomeService
  def permitted_methods
    [:post]
  end
end
