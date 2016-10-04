class User < ApplicationRecord
  has_many :phones, dependent: :destroy
  validates :name, presence: true

  def self.to_csv
    attributes = %w{name phones}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        phones = []
        user.phones.each { |ph| phones << ph.number }
        csv << [user.attributes.values_at("name"),phones]
      end
    end
  end

  def self.import(file)
    byebug
      CSV.foreach(file.path ,headers: true ) do |row|
          User.create!()
      end

  end

end
