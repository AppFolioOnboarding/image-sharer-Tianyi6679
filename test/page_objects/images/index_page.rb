module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.row', item_locator: '.col-sm-auto', contains: ImageCard do
        def view!
          node.click_on 'View'
          window.change_to ShowPage
        end
      end

      def add_new_image!
        node.click_on 'Add your own images'
        window.change_to NewPage
      end

      def showing_image?(url:, tags: nil)
        images.each do |img|
          tag_match = tags.nil? ? true : img.tags == tags
          return true if tag_match && (img.url == url)
        end
        false
      end

      def clear_tag_filter!
        node.click_on 'Show All'
        window.change_to IndexPage
      end
    end
  end
end
