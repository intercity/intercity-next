module ApplicationHelper
  def gravatar_url(email, size: 35)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
end
