class UserInvitations::NewPage < MainLayout
  needs operation : InviteUser
  needs team : Team
  quick_def page_title, "Invite user"

  def content
    form_for UserInvitations::Create.with(@team.id) do
      mount Shared::Field, attribute: @operation.invitee_email
      submit "Invite", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
