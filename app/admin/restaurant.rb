ActiveAdmin.register Restaurant do

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

  permit_params :name, :address, :address2, :phone, :latitude, :longitude, :open_and_close, :regular_holiday, :seats, :access, {:urls_attributes => [:id, :title, :url, :url_type_id]}

  index do
    column :name
    column :address_combined do |restaurant|
      [restaurant.address, restaurant.address2].join
    end
    column :phone
    actions
  end

  show do
    attributes_table do
      row :name
      row :address_combined do
        [restaurant.address, restaurant.address2].join
      end
      row :location do
        image_tag "http://maps.google.com/maps/api/staticmap?size=450x300&sensor=false&zoom=16&markers=#{restaurant.latitude}%2C#{restaurant.longitude}"
      end
      row :prefecture do
        restaurant.prefecture.name
      end
      row :yakisoba_type do
        restaurant.yakisoba_type&.name
      end
      row :phone
      row :latitude
      row :longitude
      row :open_and_close do
        restaurant.open_and_close.gsub(/\n/, "<br/>").html_safe
      end
      row :regular_holiday do
        restaurant.regular_holiday.gsub(/\n/, "<br/>").html_safe
      end
      row :seats do
        restaurant.seats.gsub(/\n/, "<br/>").html_safe
      end
      row :access do
        restaurant.access.gsub(/\n/, "<br/>").html_safe
      end
      row :url do
        restaurant.urls.collect{|u|
          name = (u.url_type ? u.url_type.name : u.title) || u.url
          link_to(u.url, u.url, {:target => "blank"}) + " (" + name + ")"
        }.join("<br/>").html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :address2
      f.input :prefecture
      f.input :yakisoba_type
      f.input :phone
      f.input :latitude
      f.input :longitude
    end
    f.inputs do
      f.has_many :urls, :allow_destroy => true, :new_record => true do |u|
        # u.input :title, as: :string
        u.input :url, as: :string
        u.input :url_type
      end
    end
    f.inputs do
      f.input :open_and_close, :input_html => { :rows => 4 }
      f.input :regular_holiday, :input_html => { :rows => 4 }
      f.input :seats, :input_html => { :rows => 4 }
      f.input :access, :input_html => { :rows => 4 }
    end
    f.actions
  end
end
