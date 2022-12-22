# frozen_string_literal: true
require 'spec_helper'

cred = YAML.load_file('config/test_data.yml')
error_message = 'Epic sadface: Username and password do not match any user in this service'
username_error_message = 'Username is required'
password_error_message = 'Password is required'

feature 'Visit saucedemo.com' do
  background do
    visit '/'
  end

  scenario 'Navigate to the website' do
    expect(page).to have_xpath("//*[@id='root']/div/div[1]")
  end

  scenario 'Login with valid username and valid password' do
    fill_in('Username', with: cred.fetch('username')['standard_user'])
    fill_in('Password', with: cred.fetch('password')['all_password'])
    click_button('Login')
    expect(page).to have_xpath("//*[@id='header_container']/div[2]/div[1]")
  end

  scenario 'Login with invalid username and valid password' do
    fill_in('Username', with: cred.fetch('username')['invalid_user'])
    fill_in('Password', with: cred.fetch('password')['all_password'])
    click_button('Login')
    expect(page).to have_content(error_message)
  end

  scenario 'Login with valid username and invalid password' do
    fill_in('Username', with: cred.fetch('username')['standard_user'])
    fill_in('Password', with: cred.fetch('password')['invalid_password'])
    click_button('Login')
    expect(page).to have_content(error_message)
  end

  scenario 'Login with invalid username and invalid password' do
    fill_in('Username', with: cred.fetch('username')['invalid_user'])
    fill_in('Password', with: cred.fetch('password')['invalid_password'])
    click_button('Login')
    expect(page).to have_content(error_message)
  end

  scenario 'Left blank the username and password field' do
    click_button('Login')
    expect(page).to have_content(username_error_message)
  end

  scenario 'Left blank only the password field' do
    fill_in('Username', with: cred.fetch('username')['invalid_user'])
    click_button('Login')
    expect(page).to have_content(password_error_message)
  end
end
