module SessionsHelper

  def deny_access
	store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
	def authenticate
		deny_access unless signed_in?
	end
  
  def current_user?(user)
	user == current_user
  end
  
  def redirect_back_or(default)
	redirect_to(session[:return_to] || default)
	clear_return_to
  end
  
  def truncate_html(text, max_length, ellipsis = "...")
    ellipsis_length = ellipsis.length     
    doc = Nokogiri::HTML::DocumentFragment.parse text
    content_length = doc.inner_text.length
    actual_length = max_length - ellipsis_length
    content_length > actual_length ? doc.truncate(actual_length).inner_html + ellipsis : text.to_s
  end
  
  private
	
	def store_location
		session[:return_to] = request.fullpath
	end
	
	def clear_return_to
		session[:return_to] = nil
	end
  
end

module NokogiriTruncator
  module NodeWithChildren
    def truncate(max_length)
      return self if inner_text.length <= max_length
      truncated_node = self.dup
      truncated_node.children.remove

      self.children.each do |node|
        remaining_length = max_length - truncated_node.inner_text.length
        break if remaining_length <= 0
        truncated_node.add_child node.truncate(remaining_length)
      end
      truncated_node
    end
  end

  module TextNode
    def truncate(max_length)
      Nokogiri::XML::Text.new(content[0..(max_length - 1)], parent)
    end
  end

end

Nokogiri::HTML::DocumentFragment.send(:include, NokogiriTruncator::NodeWithChildren)
Nokogiri::XML::Element.send(:include, NokogiriTruncator::NodeWithChildren)
Nokogiri::XML::Text.send(:include, NokogiriTruncator::TextNode)