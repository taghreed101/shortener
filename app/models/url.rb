class Url < ActiveRecord::Base
    belongs_to :user, { class_name: "User" }
    before_save :generate_the_short_url
     # validates :url, presence: true
    URL_REGEXP = URI.regexp
   # validates :url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }
    validates_format_of :url, with: /(http|https):\/\/[a-zA-Z0-9\-\#\/\_]+\.[a-zA-Z0-9\-\.\#\/\_]+/i , message: 'You provided invalid URL'
def generate_the_short_url
 # byebug
     new_url_binary= self.url.unpack("B*")
     new_url=Base58.int_to_base58(new_url_binary[0].to_i, :bitcoin).split("").sample(6).join
   
    self.short_url =URI.join("http://localhost:9393/"+new_url)
end

    


      
      def validate
        byebug
        begin
          uri = URI.parse(self.url)
          if uri.class != URI::HTTP
            errors.add(:url, 'Only HTTP protocol addresses can be used')
          end
        rescue URI::InvalidURIError
            errors.add(:url, 'The format of the url is not valid.')
        end
        true
      end
    

end

