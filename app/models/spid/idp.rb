module Spid

  class Idp
    @list = YAML.load_file(
      Spid::Rails::Engine.root.join("config", "spid-rails", "idp_list.yml")
    )

    attr_reader :metadata_url

    def self.find(name)
      raise "Idp not found" unless @list.key?(name)
      idp_attributes = @list[name]
      new(idp_attributes.symbolize_keys)
    end

    def initialize(metadata_url:, validate_cert: true)
      @metadata_url = metadata_url
      @validate_cert = validate_cert
    end

    def validate_cert?
      @validate_cert
    end

  end

end
