class ApplicationPolicy
  include UserRoleMatchers
  attr_reader :user, :record

  def initialize(user, record = nil)
    @user = user
    @record = record
  end

  def index?
    system_admin?
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    system_admin?
  end

  def new?
    create?
  end

  def update?
    system_admin?
  end

  def edit?
    update?
  end

  def destroy?
    system_admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    include UserRoleMatchers
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if system_admin?
        scope
      else
        scope.none
      end
    end
  end
end
