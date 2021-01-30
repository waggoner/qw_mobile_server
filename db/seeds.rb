admin = AdminUser.where(email: 'admin@quantwrestling.com').first
unless admin
  AdminUser.create(
    {
      email: 'admin@quantwrestling.com',
      password: 'Stats!',
      password_confirmation: 'Stats!'
    }
  )
end
