module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :title
        element :url_form, locator: '.image_url' do
          element :url, locator: '.col-sm-9 > input'
          element :error_message, locator: '.col-sm-9 > .invalid-feedback'
        end
        element :tags, locator: '.image_tag_list > .col-sm-9 > input'
        element :submit, locator: '.btn.btn-primary'
      end

      def create_image!(url: nil, tags: nil)
        url_form.url.set(url) if url.present?
        self.tags.set(tags) if tags.present?
        title.set('dummy, title')
        submit.node.click
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
