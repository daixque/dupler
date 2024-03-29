# frozen_string_literal: true

require "dupler/version"
require "dupler/cli"

# Dupler Module
module Dupler
  class DuplerException < StandardError; end

  def self.home
    @dupler_home = File.join File.dirname(__FILE__), "../"
  end
end
