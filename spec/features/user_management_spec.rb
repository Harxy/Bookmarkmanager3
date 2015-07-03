feature 'User sign up' do

  def sign_up(email: 'alice@example.com',
              password: 'oranges!',
              password_confirmation: 'oranges!')
      visit '/users/new'
      expect(page.status_code).to eq(200)
      fill_in :email,   with: email
      fill_in :password, with: password
      fill_in :password_confirmation, with: password_confirmation
      click_button 'Sign up'
  end

  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'notoranges!') }.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    # expect(status_code).to eq 200
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'requires the email not to be blank' do
    expect { sign_up( email: '') }.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    expect(page).to have_content 'Email must not be blank'

  end

  scenario 'I cannot sign up with an existing email' do
    sign_up
  expect { sign_up }.to change(User, :count).by(0)
  expect(page).to have_content('Email is already taken')
  end

end
