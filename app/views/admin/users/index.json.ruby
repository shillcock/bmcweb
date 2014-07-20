{
  data: @users.map do |user|
    {
      id: user.id,
      name: link_to(user.name, [:admin, user]),
      email: link_to(user.email, [:admin, user]),
      birthday: user.birthday
    }
  end
}.to_json
