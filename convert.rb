#!/usr/local/bin/ruby -w

require 'bundler/inline'
gemfile do
	source 'https://rubygems.org'
	gem 'mini_magick'
end

require 'fileutils'
require 'mini_magick'
require 'tempfile'



Dir.chdir('/home/conversion/image')



# Prevent multiple instances of the script from being run.
exit if File.exist?('lockfile')
File.open('lockfile', 'w+')



# Ensure required folders exist.
%w(todo complete).each { |dirname| Dir.mkdir(dirname) unless Dir.exist?(dirname) }



# Convert files.
extensions = %w(bmp jpg jpeg png raw)
widths = [1920, 1366, 854, 320]

dir_todo = "#{Dir.pwd}/todo"

extensions.each do |extension|
	Dir.glob("#{dir_todo}/**/*.#{extension}").each do |file_path|
		file_dirname = File.dirname(file_path)
		file_basename = File.basename(file_path).sub(".#{extension}", '')

		output_folder = "#{Dir.pwd}/complete/#{file_dirname.sub(dir_todo, '')}/#{file_basename}".sub('//', '/')
		FileUtils.mkdir_p(output_folder) unless Dir.exist?(output_folder)

		widths.each do |width|
			image = MiniMagick::Image.open(file_path)
			next unless image.width > width

			image.resize(width)
			image.write("#{output_folder}/#{file_basename}_#{width}.#{extension}")
		end

		FileUtils.mv(file_path, "#{output_folder}/#{File.basename(file_path)}")
	end
end



# Delete leftover folders.
# See https://stackoverflow.com/a/22854135/13279616
Dir["#{dir_todo}/**/*"].reverse_each { |d| Dir.rmdir(d) if Dir.empty?(d) }



File.delete('lockfile')
