# -*- encoding: utf-8 -*-

require 'thor'
require 'json'
require "dupler/core"

module Dupler
  class Cli < Thor
    @@defalut_conf_name = "./values.yaml"

    default_command :build

    desc :new, "create new dupler project."
    def new_project(name)
      core = Dupler::Core.new
      core.new_project(name)
    end

    desc :build, "build documents."
    option "conf", aliases: "c", type: :string
    def build(output_dir = "./output", *template_files)
      if template_files.empty?
        templates_dir = './templates'
        if !Dir.exists?(templates_dir)
          raise DuplerException.new("No such template directory: #{templates_dir}")
        end

        Dir.glob(File.join(templates_dir, '*')) do |f|
          template_files << f
        end
      end
      
      extract_template_files = []
      template_files.each do |f|
        if File.directory?(f)
          files = Dir.glob(File.join(f, '*'))
          extract_template_files.concat files
        else
          extract_template_files << f
        end
      end

      values_file_path = options['conf'] || @@defalut_conf_name
      if !File.exists? values_file_path
        raise DuplerException.new("No such conf file: #{values_file_path}")
      end

      core = Dupler::Core.new
      core.build(values_file_path, output_dir, extract_template_files)
    end
  end
end
