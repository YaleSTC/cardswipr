# frozen_string_literal: true

require './lib/api/person_request.rb'
# Person API helper function
def file_to_response(path, code_num)
  unless path.nil?
    file = File.read(path)
    format = File.extname(path).from(1).downcase.to_sym
    parser = HTTParty::Parser.new(file, format)
    data = parser.parse
  end
  instance_double('response',
                  response: instance_double('child_response', code: code_num),
                  parsed_response: data)
end

def mock_successful_api_call
  response = file_to_response("#{RSPEC_ROOT}/fixtures/api/success.json", 200)
  allow(HTTParty).to receive(:get) { response }
end
