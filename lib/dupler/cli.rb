# frozen_string_literal: true

require "thor"
require "json"
require "dupler/core"

module Dupler
  # CLI class for dupler command based Thor
  class Cli < Thor
    DEFAULT_CONF_PATH = "./values.yaml"

    default_command :build

    desc :new, "create new dupler project."
    def new_project(name)
      core = Dupler::Core.new
      core.new_project(name)
    end

    desc :build, "build documents."
    option "conf", aliases: "c", type: :string
    option "version", aliases: "v", type: :boolean
    def build(output_dir = "./output", *template_path)
      if options["version"]
        puts "dupler #{Dupler::VERSION}"
        return
      end

      extracted_template_files = extract_template_files(template_path)

      values_file_path = options["conf"] || DEFAULT_CONF_PATH
      raise DuplerException, "No such conf file: #{values_file_path}" unless File.exist? values_file_path

      core = Dupler::Core.new
      begin
        core.build(values_file_path, output_dir, extracted_template_files)
      rescue Errno::EACCES => e
        raise DuplerException.new(e)
      end
    end

    private

    def extract_template_files(template_path)
      template_files = find_template_files(template_path)

      extract_template_files = []
      template_files.each do |f|
        if File.directory?(f)
          extract_template_files.concat Dir.glob(File.join(f, "*"))
        else
          extract_template_files << f
        end
      end
      extract_template_files
    end

    def find_template_files(template_files)
      if template_files.empty?
        templates_dir = "./templates"
        raise DuplerException, "No such template directory: #{templates_dir}" unless Dir.exist?(templates_dir)

        Dir.glob(File.join(templates_dir, "*")) do |f|
          template_files << f
        end
      end
      template_files
    end
  end
end
