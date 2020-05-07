require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'new' do
    get new_image_path
    assert_equal 'new', @controller.action_name
    assert_response :success
    assert_select 'form input' do
      assert_select '[name=?]', 'image[title]'
      assert_select '[name=?]', 'commit'
    end

    assert_select 'form textarea' do
      assert_select '[name=?]', 'image[url]'
    end
  end

  test 'successful create' do
    valid_image_params = {
      title: 'test is only 4-character-long but we need 5',
      url: 'https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg'
    }
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: valid_image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'You have successfully saved an image.', flash[:success]
    assert_equal Image.last.title, valid_image_params[:title]
    assert_equal Image.last.url, valid_image_params[:url]
  end

  test 'unsuccessful create' do
    invalid_image_params = {
      title: 'test',
      url: 'this is an invalid url'
    }

    assert_no_difference 'Image.count' do
      post images_path, params: { image: invalid_image_params }
    end

    assert_select '#title_error', 'Title is too short (minimum is 5 characters)'
    assert_select '#url_error', 'Please enter a valid URL'
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
