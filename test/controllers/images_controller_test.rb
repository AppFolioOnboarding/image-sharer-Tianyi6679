require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
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
    assert_redirected_to image_path(img)
    assert_equal 'You have successfully saved an image.', flash[:success]
    assert_equal img.title, valid_image_params[:title]
    assert_equal img.url, valid_image_params[:url]
    assert_equal img.tag_list.count, 2
    assert_equal img.tag_list.to_s, valid_image_params[:tag_list]

    valid_image_params.delete :tag_list
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: valid_image_params }
    end

    img = Image.last
    assert_equal img.tag_list.count, 0
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
        assert_select 'button', 'tag1'
        assert_select 'button', 'tag2'
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
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg'
    )
    get image_path(@test_image.id)
    assert_response :success
    assert_select '#title', @test_image.title
    assert_select 'img' do
      assert_select '[src=?]', @test_image.url
    end
  end
end
