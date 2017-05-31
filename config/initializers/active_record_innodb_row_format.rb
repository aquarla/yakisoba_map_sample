# -*- coding: utf-8 -*-
# ROW_FORMAT=DYMANICでテーブルを作成する
# http://qiita.com/kamipo/items/101aaf8159cf1470d823
# http://qiita.com/kamipo/items/101aaf8159cf1470d823#comment-6a9c50b52e94b8d2cc08
if Rails.env.production?
  module InnodbRowFormat
    def create_table(table_name, options = {})
      table_options = options.merge(options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC')
      super(table_name, table_options) do |td|
        yield td if block_given?
      end
    end
  end

  ActiveSupport.on_load :active_record do
    module ActiveRecord::ConnectionAdapters
      class AbstractMysqlAdapter
        prepend InnodbRowFormat
      end
    end
  end
end
