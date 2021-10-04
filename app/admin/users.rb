ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :provider, :uid, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :first_name, :last_name, :role, :tokens, :discarded_at
  #
  # or
  #
  permit_params do
    permitted = [:provider, :uid, :email, :encrypted_password, :first_name, :last_name, :role]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :role
    actions
  end
end
