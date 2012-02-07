module Rack
  module OAuth2
    module Server
      module Abstract
        class RequestWithClientID < Abstract::Request
          attr_required :client_id
          attr_optional :scope

          def initialize(env)
            super
            @client_id ||= params['client_id']
            @scope = Array(params['scope'].to_s.split(' '))
          end

          def attr_missing!
            if params['client_id'].present? && @client_id != params['client_id']
              invalid_request! 'Multiple client credentials are provided.'
            end
            super
          end
        end
      end
    end
  end
end