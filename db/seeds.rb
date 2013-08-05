# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@account = Account.create(company_name: 'FooBar Inc.', active: true)
@user = User.create(account:               Account.first,
                    first_name:            'First Name',
                    last_name:             'Last Name',
                    email:                 'foo_bar@company.com',
                    password:              'foobar',
                    account_administrator: true,
                    active:                true)
