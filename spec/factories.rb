FactoryGirl.define do
  factory :account do
    company_name 'My Company'
    active        true
  end

  factory :account_unique, class: Account do
    sequence(:company_name) { |n| "My Company #{n}" }
    active                  true
  end

  factory :user do
    account
    first_name            'First Name'
    last_name             'Last Name'
    email                 'account@company.com'
    password              'abcdef'
    account_administrator true
    active true

    factory :user_normal do
      account_administrator false
    end
  end

  factory :user_unique, class: User do
    account_unique
    sequence(:first_name) { |n| "First Name #{n}" }
    sequence(:last_name)  { |n| "Last Name #{n}" }
    sequence(:email)      { |n| "account_#{n}@company.com" }
    password              'abcdef'
    account_administrator true
    active true

    factory :user_unique_normal do
      account_administrator false
    end
  end

  factory :client do
    account
    first_name        'First Name'
    last_name         'Last Name'
    birthday          '1975-03-12'
    email             'client_1@somesite.com'
    telefone_celular  '(11) 96122-4013'
    telefone_home     '(11) 3025-5252'
    telefone_office   '(11) 3295-2905'
  end
end
