# -*- coding: utf-8 -*-
class Restaurant < ApplicationRecord
  geocoded_by :address
  # after_validation :geocode, if: :address_changed?
  after_validation :geocode, if: ->(obj){ (obj.latitude.blank? || obj.longitude.blank?) && obj.address.present? && obj.address_changed? }

  after_validation :fill_prefecture

  has_many :urls
  belongs_to :prefecture
  belongs_to :yakisoba_type

  accepts_nested_attributes_for :urls, :allow_destroy => true
 
  # 住所から自動的に都道府県レコードを関連付ける
  def fill_prefecture
    if prefecture.blank?
      Prefecture.all.each do |pref|
        if address.start_with?(pref.name)
          self.prefecture = pref
          break
        end
      end
    end
  end

  def address_combined
    [address, address2].join(" ")
  end
end
