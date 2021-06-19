# Dupler

This project is created by Dupler.

# Usage

By default, below files are there in this project directory.

 - values.yaml : You can define any values for placeholder in the templates
 - templates : In this directory, all files will be processed by dupler as template file.

You can just execute `dupler` command on top of your project folder, then output file will be generated in `output` directory.

    $ dupler

Or you can specify like below

    $ dupler -c values.yaml output templates/*
