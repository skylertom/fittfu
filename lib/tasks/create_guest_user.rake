namespace :db do
  desc "Fill database with sample players and teams"
  task make_guest_user: :environment do
    i = Invitation.create()
    User.create(id: "2fa8c788-1dec-4500-9721-95253f6a9322",
                name: "Guest User",
                email: Rails.configuration.guest_email,
                password: Rails.configuration.guest_password,
                password_confirmation: Rails.configuration.guest_password,
                admin: false,
                commissioner: false)
  end
end