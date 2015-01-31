require "coffee-script"

namespace :js do
  desc "compile coffee-scripts from ./assets/coffee to ./public/javascripts"
  task :compile do
    source = "#{File.dirname(__FILE__)}/assets/coffee/"
    javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"

    Dir.foreach(source) do |cf|
      unless cf == "." || cf == ".."
        js = CoffeeScript.compile File.read("#{source}#{cf}")
        open "#{javascripts}#{cf.gsub(".coffee", ".js")}", "w" do |f|
          f.puts js
        end
      end
    end
  end
end
