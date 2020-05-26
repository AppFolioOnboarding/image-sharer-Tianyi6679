require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  test 'new' do
    get new_image_path
    assert_equal 'new', @controller.action_name
    assert_response :success
    assert_select '.form-control' do
      assert_select '[name=?]', 'image[title]'
      assert_select '[name=?]', 'image[url]'
      assert_select '[name=?]', 'image[tag_list]'
    end
    assert_select 'form input[type=submit][value=?]', 'Create Image'
  end

  test 'successful create' do
    valid_image_params = {
      title: 'test is only 4-character-long but we need 5',
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
      tag_list: 'tag1, tag2'
    }
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: valid_image_params }
    end

    img = Image.last
    assert_equal 'You have successfully added an image.', flash[:success]
    assert_equal img.title, valid_image_params[:title]
    assert_equal img.url, valid_image_params[:url]
    assert_equal img.tag_list.count, 2
    assert_equal img.tag_list.to_s, valid_image_params[:tag_list]
  end

  test 'unsuccessful create' do
    invalid_image_params = {
      title: 'test',
      url: 'this is an invalid url'
    }

    assert_no_difference 'Image.count' do
      post images_path, params: { image: invalid_image_params }
    end

    assert_select '.invalid-feedback', 'Title is too short (minimum is 5 characters)'
    assert_select '.invalid-feedback', 'Url is invalid'
    assert_select '.invalid-feedback', "Tag list can't be blank"
  end

  test 'index' do
    image_params = {
      title: 'test tag list',
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
      tag_list: 'tag1, tag2'
    }
    Image.create!(image_params)
    get images_path
    assert_response :success
    assert_select '#page-header', 'All Images'
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end

    assert_select '.alert.alert-info', 'Filter Status: No tag is selected'
    assert_select '.card', 3 do
      assert_select '.card-text', 'No Tag', 2
      assert_select '.card-block' do
        assert_select '.card-title', 'test tag list'
        assert_select '.btn', 'tag1'
        assert_select '.btn', 'tag2'
      end
    end
  end

  test 'index_with_filter' do
    image_params = {
      title: 'test tag list',
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
      tag_list: 'tag1'
    }
    Image.create!(image_params)
    get images_path, params: { tag_filter: 'tag1' }

    assert_select '.alert.alert-info', 'Filter Status: Tag tag1 is selected'
    assert_select '.card', 1 do
      assert_select '.card-title', 'test tag list'
    end
  end

  test 'show' do
    @test_image = Image.create!(
      title: 'A testing sample',
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg',
      tag_list: 'tag1'
    )
    get image_path(@test_image.id)
    assert_response :success
    assert_select '#title', @test_image.title
    assert_select 'img' do
      assert_select '[src=?]', @test_image.url
    end
  end

  test 'successful update' do
    update_image_params = {
      title: 'I update my title',
      tag_list: 'this, tag, list, is, updated'
    }
    img = Image.first
    put image_path(img), params: { image: update_image_params }

    assert_redirected_to image_path(img)
    img.reload
    assert_equal update_image_params[:title], img.title
    assert_equal update_image_params[:tag_list], img.tag_list.to_s
  end

  test 'unsuccessful update' do
    update_image_params = {
      title: 't',
      tag_list: 'dd'
    }
    img = Image.first
    put image_path(img), params: { image: update_image_params }

    assert_select '.invalid-feedback', 'Title is too short (minimum is 5 characters)'

    img.reload
    assert_not_equal update_image_params[:title], img.title
    assert_not_equal update_image_params[:tag_list], img.tag_list.to_s
  end

  test 'destroy' do
    @image_deleted = Image.first
    assert_difference 'Image.count', -1 do
      delete image_path(@image_deleted)
    end

    assert_redirected_to images_path
    assert_select "img[src='#{@image_deleted.url}']", false
    assert_equal 'You have successfully deleted the image.', flash[:success]

    assert_no_difference 'Image.count' do
      delete image_path(@image_deleted)
    end

    assert_redirected_to images_path
    assert_equal 'An error occurred! Please try again.', flash[:error]
  end
end
