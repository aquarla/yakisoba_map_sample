# -*- coding: utf-8 -*-
module ApplicationHelper
  # Google Map APIのscriptタグを出力
  def google_map_script_tag
    key = Rails.env.production? ? Yakisoba::Application.config.google_map_api_key : ""
    url = "//maps.google.com/maps/api/js?v=3&amp;libraries=geometry"
    if key.present?
      url += "&key=" + key
    end
    content_tag :script, "", :src => url, :type => "text/javascript"
  end

  # Google Static Map APIのimgタグを出力
  def google_static_map_image_tag(restaurant)
    key = Rails.env.production? ? Yakisoba::Application.config.google_static_map_api_key : ""
    url = "http://maps.google.com/maps/api/staticmap?size=640x320&sensor=false&zoom=16&markers=#{restaurant.latitude}%2C#{restaurant.longitude}"
    if key.present?
      url += "&key=" + key
    end
    image_tag url
  end

  # 都道府県別店舗ページのリンク
  def area_link_tags(prefectures)
    content_tag :div, :class => "callout prefectures-list" do
      prefectures.collect{|pref|
         pref.restaurants.present? ?
	   link_to(pref.name, map_area_path(pref.code)) :
           pref.name
       }.join(" ").html_safe 
    end
  end


  # デフォルトのmetaタグ
  def default_meta_tags
  {
    site:       Yakisoba::Application.config.application_name,
    description: '日本やきそばマップは、日本全国で美味しいやきそばが食べられるお店をまとめた、やきそばファンのための情報サイトです。',
    keywords:    ['やきそば', '焼きそば', 'ヤキソバ'],
    separator:   "|",
    reverse: true,
    og: { 
      title: :title,
      description: '日本やきそばマップは、日本全国で美味しいやきそばが食べられるお店をまとめた、やきそばファンのための情報サイトです。',
    }
  }
  end

  def nl2br(str)
    return sanitize(str).gsub("\n", '<br>').html_safe
  end
end
