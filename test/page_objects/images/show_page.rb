module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      element :title, locator: '#title'
      element :tag_list, locator: '#tag'
      element :delete_btn, locator: '.btn'

      def image_url
        node.find('img')[:src]
      end

      def tags
        tag_list.text.split(', ')
      end

      def delete
        delete_btn.node.click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        delete do |confirm_dialog|
          confirm_dialog.accept
        end

        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on 'Show All'
        window.change_to(IndexPage)
      end
    end
  end
end
