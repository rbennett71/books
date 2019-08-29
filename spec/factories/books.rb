FactoryBot.define do
  factory :book do
    title {"SAMPLE BOOK"}
    author_last_name {"Joyce"}
    sequence :isbn do |x|
      "MDWX000#{x}"
    end
  end
end
