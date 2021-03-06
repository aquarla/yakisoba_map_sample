ActiveAdmin.register Url do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :title, :url, :url_type_id

  form do |f|
    f.inputs do
      f.input :title, :as => :string
      f.input :url, :as => :string
      f.input :url_type
    end
  end

end
