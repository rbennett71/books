FactoryBot.define do
  factory :book do
    title {"SAMPLE BOOK"}
    sequence :isbn do |x|
      "MDWX000#{x}"
    end
  end
end
