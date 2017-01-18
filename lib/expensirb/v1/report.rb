require 'json'
require 'expensirb/v1/constants'

module Expensirb
  class Report

    def export(method, opts={}, template)
      requestJobDescription = {}
      requestJobDescription[:type] = "file"
      requestJobDescription[:credentials] = Expensirb::Constants::CREDENTIALS
      requestJobDescription[:test] = opts[:test] unless opts[:test].nil?
      requestJobDescription[:limit] = opts[:limit] unless opts[:limit].nil?
      requestJobDescription[:onFinish] = opts[:onFinish] unless opts[:onFinish].nil?

      # onReceive
      requestJobDescription[:onReceive] = opts[:onReceive]

      # inputSettings
      inputSettings = {}
      inputSettings[:type] = "combinedReportData"
      inputSettings[:filters] = opts[:inputSettings][:filters]
      inputSettings[:reportState] = opts[:inputSettings][:reportState] unless opts[:inputSettings][:reportState].nil?
      inputSettings[:employeeEmail] = opts[:inputSettings][:employeeEmail] unless opts[:inputSettings][:employeeEmail].nil?
      requestJobDescription[:inputSettings] = inputSettings

      # outputSettings

      outputSettings = {}
      outputSettings[:fileExtension] = opts[:outputSettings][:fileExtension]
      outputSettings[:fileBasename] = opts[:outputSettings][:fileBasename] unless opts[:outputSettings][:fileBasename].nil?
      outputSettings[:includeFullPageReceiptsPdf] = opts[:outputSettings][:includeFullPageReceiptsPdf] unless opts[:outputSettings][:includeFullPageReceiptsPdf].nil?
      requestJobDescription[:outputSettings] = outputSettings

      final_json = Expensirb::Constants::PARAMS_PREFIX + requestJobDescription.to_json

      #puts final_json

      Expensirb.make_request method, Expensirb::Constants::API_URL, final_json, template
    end

    def create(method, opts={})
      requestJobDescription = {}
      requestJobDescription[:type] = "create"
      requestJobDescription[:credentials] = Expensirb::Constants::CREDENTIALS

      # inputSettings
      inputSettings = {}
      inputSettings[:type] = "report"
      inputSettings[:employeeEmail] = opts[:employeeEmail]
      inputSettings[:report] = opts[:report]
      inputSettings[:expenses] = opts[:expenses]
      inputSettings[:policyID] = opts[:policyID]

      requestJobDescription[:inputSettings] = inputSettings

      final_json = Expensirb::Constants::PARAMS_PREFIX + requestJobDescription.to_json
      Expensirb.make_request method, Expensirb::Constants::API_URL, final_json
    end

    def status_update(method, opts={})
      requestJobDescription = {}
      requestJobDescription[:type] = "update"
      requestJobDescription[:credentials] = Expensirb::Constants::CREDENTIALS

      # inputSettings
      inputSettings = {}
      inputSettings[:type] = "reportStatus"
      inputSettings[:filters] = opts[:filters]
      inputSettings[:status] = opts[:status]
      requestJobDescription[:inputSettings] = inputSettings

      final_json = Expensirb::Constants::PARAMS_PREFIX + requestJobDescription.to_json
      Expensirb.make_request method, Expensirb::Constants::API_URL, final_json
    end

    def download(method, opts={})
      requestJobDescription = {}
      requestJobDescription[:type] = "download"
      requestJobDescription[:credentials] = Expensirb::Constants::CREDENTIALS
      requestJobDescription[:fileName] = opts[:fileName]

      final_json = Expensirb::Constants::PARAMS_PREFIX + requestJobDescription.to_json

      Expensirb.make_request method, Expensirb::Constants::API_URL, final_json, nil
    end
  end
end
