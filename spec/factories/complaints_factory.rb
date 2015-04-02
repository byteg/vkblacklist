FactoryGirl.define do
  factory :complaint do
    url 'https://vk.com/club40355809'
    account
  end

  factory :closed_complaint, class: Complaint do
    comment "closed"
    url 'https://vk.com/club40355809'
    account
  end
end
