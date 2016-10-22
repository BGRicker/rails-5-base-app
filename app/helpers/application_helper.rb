module ApplicationHelper
  include ActiveSupport::Inflector

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success
        "alert-success alert-dismissable"
      when :error
        "alert-danger alert-dismissable"
      when :alert
        "alert-warning alert-dismissable"
      when :notice
        "info alert-info alert-dismissable"
      else
        flash_type.to_s
    end
  end
end
