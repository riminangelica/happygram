class Comment < ActiveRecord::Base
  include TheComments::Comment

  attr_accessible :title, :contacts, :raw_content, :parent_id, :commentable_title, :commentable_url, :ip, :referer, :user_agent, :tolerance_time, :user, :view_token


  # ---------------------------------------------------
  # Define comment's avatar url
  # Usually we use Comment#user (owner of comment) to define avatar
  #  @entry.comments.includes(:user) <= use includes(:user) to decrease queries count
  # comment#user.avatar_url
  # ---------------------------------------------------

  # public
  # ---------------------------------------------------
  # Simple way to define avatar url
  #
  # def avatar_url
  #   src = id.to_s
  #   src = title unless title.blank?
  #   src = contacts if !contacts.blank? && /@/ =~ contacts
  #   hash = Digest::MD5.hexdigest(src)
  #   "https://2.gravatar.com/avatar/#{hash}?s=42&d=https://identicons.github.com/#{hash}.png"
  # end
  # ---------------------------------------------------

  # private
  # ---------------------------------------------------
  # Define your content filters
  
  def prepare_content
    text = self.raw_content
    text = RedCloth.new(text).to_html
    text = Sanitize.clean(text, Sanitize::Config::RELAXED)
    self.content = text
  end
  # ---------------------------------------------------
end