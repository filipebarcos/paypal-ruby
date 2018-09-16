# frozen_string_literal: true

require 'rspec'
require 'rspec/core/rake_task'

desc "Run all examples"
RSpec::Core::RakeTask.new(:test) do |t|
  t.ruby_opts = %w[-w]
  t.rspec_opts = %w[--color]
end

task default: :test
