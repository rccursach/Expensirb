require 'json'
require 'expensirb/v1/constants'

module Expensirb
  class Reconciliation

    def download(method, opts={})
      requestJobDescription = {}
      requestJobDescription[:type] = "reconciliation"
      requestJobDescription[:credentials] = Expensirb::Constants::CREDENTIALS

      # inputSettings
      inputSettings = {}
      inputSettings[:startDate] = opts[:startDate] || "2016-01-01"
      inputSettings[:endDate] = opts[:endDate] || "2016-12-12"
      inputSettings[:domain] = opts[:domain] || "expensify.com"
      inputSettings[:feed] = opts[:feed] || "export_all_feeds"
      inputSettings[:type] = opts[:type] || "Unreported"
      inputSettings[:async] = opts[:async] ||  false
      requestJobDescription[:inputSettings] = inputSettings

      # outputSettings

      outputSettings = {}
      outputSettings[:fileExtension] = opts[:fileExtension] || 'csv'
      requestJobDescription[:outputSettings] = outputSettings

      # template
      #requestJobDescription[:template] = template

      final_json = Expensirb::Constants::PARAMS_PREFIX + requestJobDescription.to_json

      Expensirb.make_request :post, Expensirb::Constants::API_URL, final_json
    end

  end
end
