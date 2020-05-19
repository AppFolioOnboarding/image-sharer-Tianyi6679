module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      collection :tag_list, locator: '.card-text', item_locator: '.btn' do
        element :tag
      end

      def url
        node.find('img')[:src]
      end

      def tags
        tag_list.map(&:text)
      end

      def click_tag!(tag_name)
        node.click_on tag_name
        window.change_to(IndexPage)
      end
    end
  end
end
