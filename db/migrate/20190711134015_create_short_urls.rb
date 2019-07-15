class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    def self.up
      create_table :short_urls do |t|
        t.text    :url
        t.text    :short_url

        t.timestamps
      end
    end
  
    def self.down
      drop_table :short_urls
    end
  end
end
