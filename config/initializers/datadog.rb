# frozen_string_literal: true

require 'ddtrace'

Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails
  c.tracer hostname: ENV.fetch('DD_AGENT_HOST'), port: 8126
end
