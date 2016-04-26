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

	class Scope
		attr_reader :user, :scope

		def initialize(user, scope)
			@user = user
			@scope = scope
		end

		def resolve
			wikis = []
			if @user.role == 'admin'
				wikis = @scope.all
			elsif user.role == 'premium'
				all_wikis = @scope.all
				all_wikis.each do |wiki|
					if !wiki.private? || wiki.user == @user || wiki.collaborators.include?(@user)
						wikis << wiki
					end
				end
			else
				all_wikis = @scope.all
				wikis = []
				all_wikis.each do |wiki|
					if !wiki.private? || wiki.collaborators.include?(@user)
						wikis << wiki
					end
				end
			end
			wikis
		end
	end
end