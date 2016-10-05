class User < ApplicationRecord
  has_many :phones, dependent: :destroy
  validates :name, presence: true

  def self.to_csv
    attributes = %w{name}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        row = []
        row << user.name
        user.phones.each { |ph| row << ph.number }
        csv << row
      end
    end
  end

  def self.import(file)
      CSV.foreach(file.path ,headers: true ) do |row|
          @user = User.find_by(name: row[0])
          if @user
              row.delete("name")
              row.each do |key ,value|
                @phone = Phone.find_by(number: value)
                unless @phones.present?
                  @user.phones.create(number: value)
                end
              end
          else
            @user = User.create(name: row[0])
            row.delete("name")
            if row.length > 1
              row.each do |key ,value|
                byebug
                @user.phones.create(number: value)
              end
            end
          end

      end

  end

end
