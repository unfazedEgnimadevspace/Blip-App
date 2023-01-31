module UsersHelper
    def gravatar_for(user, options = { size: 80 })
        size = options[:size]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "mx-auto h-32 w-32 flex-shrink-0 rounded-full object-cover")
    end
    
end
