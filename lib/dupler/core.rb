# frozen_string_literal: true

require "tilt"
require "yaml"
require "hashie"
require "fileutils"
require "active_support/all"

module Dupler
  # Dupler core functions
  class Core
    def new_project(project_name)
      FileUtils.mkdir_p project_name
      project_template_dir = Dir.glob File.join(Dupler.home, "project_template/*")
      FileUtils.cp_r(project_template_dir, project_name)
    end

    def setup(config)
      formats = config.dig("Dupler", "time", "format")
      formats&.each do |key, value|
        Time::DATE_FORMATS[key.to_sym] = value
      end
    end

    def build(values_file_path, output_dir, template_files)
      yaml = YAML.safe_load File.read(values_file_path)

      setup(yaml)
      yaml.delete("Dupler")
      config = Hashie::Mash.new yaml
      FileUtils.mkdir_p output_dir

      template_files.each do |path|
        output_filename = File.basename(path, File.extname(path))
        output_filepath = File.join(output_dir, output_filename)
        render(path, config, output_filepath)
      end
    end

    def render(template_path, config, output_filepath)
      content = apply_template(template_path, config)
      output_file(output_filepath, content)
      puts "render: #{output_filepath}"
    end

    def apply_template(template_path, config)
      template = Tilt.new(template_path)
      template.render(self, config)
    end

    def output_file(filepath, content)
      File.open(filepath, "w") do |file|
        file.write content
      end
    end
  end
end
