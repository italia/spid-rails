module SpidRails

  # TODO: rinominare SSO?
  class Request
    attr_accessor :settings

    def initialize spid_params
      spid_settings = SpidRails::Settings::Request.new(spid_params)
      @settings = spid_settings.to_hash
    end

    def valid?
      true
    end

    def save
      valid?
      request = OneLogin::RubySaml::Authrequest.new
      saml_settings = OneLogin::RubySaml::Settings.new @settings
      @to_saml = request.create(saml_settings)
      self
    end

    def to_saml
      save and @to_saml
    end

    def self.create **settings
      obj = self.new(**settings)
      obj.save if obj.valid?
    end

  end

end
