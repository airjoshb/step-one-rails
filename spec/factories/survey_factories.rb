FactoryBot.define do
  factory :survey do
    title { "Sample Survey" }
  end

  factory :customer do
    name { "John Doe" }
    email { "john.doe@example.com" }
  end

  factory :question do
    question_text { "Sample Question?" }
    question_type { "choose_one" }
    survey
  end

  factory :answer_option do
    answer_text { "Sample Answer" }
    question
  end

  factory :survey_response do
    survey
    customer
  end

  factory :question_answer do
    question
    survey_response
    answer_option_ids { [] }
  end
end