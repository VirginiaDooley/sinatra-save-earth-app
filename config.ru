require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
#To perform other actions such as PUT, PATCH or DELETE, use the Rack::MethodOverride middleware
use Rack::MethodOverride
run ApplicationController
use ActionsController
use UsersController
