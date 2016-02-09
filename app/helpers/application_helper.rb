module ApplicationHelper
  def bootstrap_flash_class(flash_type)
    { success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  # determines whether the navbar is active
	def navbar_active(controller)
		if params[:controller] == controller
			'active'
		else
			''
		end
  end

  def bool_to_s(boolean)
    boolean ? 'Yep' : 'Nope'
  end
end
