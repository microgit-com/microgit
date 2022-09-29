class UserInvitations::AcceptPage < AuthLayout
  needs operation : AcceptInvitation
  needs invitation : UserInvitation
  quick_def page_title, "Accept Invitation"

  def content
    form_for UserInvitations::Accept.with(@invitation.token) do
      #mount Shared::Field, attribute: @operation.email
      mount Shared::Field, attribute: @operation.username
      mount Shared::Field, attribute: @operation.password
      mount Shared::Field, attribute: @operation.password_confirmation

      submit "Create account", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
