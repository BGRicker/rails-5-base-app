module UserRoleMatchers

  def system_admin?
    user.is_a?(Admin) && user.system_admin?
  end
  
  def permissionless?
    !has_any_permission?
  end
end
