module ServerFaking

  def self.fake_response_for(endpoint)
    key = endpoint.to_s.split('/').last
    key = key[0...key.index('?')] if key.include?('?')

    entities = [
      { 'attrOne' => 'first_value_one', 'attrTwo' => 'first_value_two' },
      { 'attrOne' => 'second_value_one', 'attrTwo' => 'second_value_two' },
      { 'attrOne' => 'third_value_one', 'attrTwo' => 'third_value_two' }
    ]
    { key => entities }
  end

  private

    def fake_server(&block)
      given_endpoint = nil
      server_proc = Proc.new do |endpoint|
        given_endpoint = endpoint
        ServerFaking.fake_response_for(endpoint).to_json
      end

      Net::HTTP.stub :get, server_proc do
        yield
      end
      given_endpoint
    end
end
