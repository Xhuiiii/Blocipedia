class User < ActiveRecord::Base
	has_many :wikis
	enum role: [:standard, :premium, :admin]
	after_initialize do
		self.role ||= :standard
	end
	attr_accessor :login

	# Include default devise modules. Others available are:
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

	#Make sure that someone's username != someone's email
	validate :validate_username

	def validate_username
		if User.where(email: username).exists?
			errors.add(:username, :invalid)
		end
	end

	def self.admin?
		self.role == :admin
	end

	def self.standard?
		self.role == :standard
	end

	def self.premium?
		self.role == :premium
	end

	def edit
		self.downgrade!
	end

	#Overwrite Devise's find_for_database_authentication method to change the behaviour of the login action. 
	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions).where(["username = :value OR lower(email) = lower(:value)", {:value => login}]).first
		else
			if conditions[:username].nil?
				where(conditions).first
			else
				where(username: conditions[:username]).first
			end
		end
	end
end
