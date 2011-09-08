# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#   
users = User.create([{:username => 'jmoren',    :email => 'jmoren@gmail.com',   :password => 'jmoren', :password_confirmation => 'jmoren' },
                     {:username => 'test',      :email => 'test@gmail.com',     :password => 'jmoren', :password_confirmation => 'jmoren' },
                     {:username => 'test1',     :email => 'test1@gmail.com',    :password => 'jmoren', :password_confirmation => 'jmoren' },
                     {:username => 'test2',     :email => 'test2@gmail.com',    :password => 'jmoren', :password_confirmation => 'jmoren' },
                     {:username => 'otrotests', :email => 'otrotest@gmail.com', :password => 'jmoren', :password_confirmation => 'jmoren' }
                    ])
