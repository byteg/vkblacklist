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

  factory :fucking_bad_complaint, class: Complaint do
    comment "fucking_bad"
    url 'https://vk.com/club40355809'
    account
  end

  factory :bad_complaint, class: Complaint do
    comment "bad"
    url 'https://vk.com/club40355809'
    account
  end

  factory :volk_complaint, class: Complaint do
    comment "volk"
    url 'https://vk.com/club40355809'
    account
  end
end
