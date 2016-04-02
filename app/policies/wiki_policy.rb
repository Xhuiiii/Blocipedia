class WikiPolicy < ApplicationPolicy
	attr_reader :user, :wiki

	def initialize(user, wiki)
		@user = user
		@wiki = wiki
	end
	
	def edit?
		admin_or_owner?
	end

	def destroy?
		admin_or_owner?
	end

	def admin_or_owner?
		@user.role == 'admin' || @user == @wiki.user
	end

	def admin_or_premium?
		@user.admin? || @user.premium?
	end
end