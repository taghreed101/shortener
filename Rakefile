require_relative './config/environment'
require 'sinatra/activerecord/rake'
# module Rails
#     class Engine < Railtie
#       def load_seed
#         seed_file = paths["db/seeds.rb"].existent.first
#         return unless seed_file
#           load(seed_file)
#       end
#     end
#   end



# desc 'Start IRB with application environment loaded'
task :console do
    exec "irb -r ./config/environment"
end

# Type `rake -T` on your command line to see the available rake tasks.
