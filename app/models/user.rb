class User < ApplicationRecord
  has_many :phones, dependent: :destroy
  validates :name, presence: true

  def self.to_csv
    attributes = %w{name}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        row = []
        byebug
        row << user.name
        user.phones.each { |ph| row << ph.number }
        csv << row
      end
    end
  end

  def self.import(file)
      CSV.foreach(file.path ,headers: true ) do |row|
          byebug
          User.create!(name: row[0])
      end

  end

end
