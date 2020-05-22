class AddTagsToTaglessImages < ActiveRecord::Migration[5.2]
  def change
    Image.all.filter {|img| img.tag_list.empty?}.each do |img|
      img.tag_list.add('please_add_tag')
      img.save!
    end
  end
end
