class PasswordResets::NewPage < AuthLayout
  needs operation : ResetPassword
  needs user_id : Int64

  def content
    h1 "Reset your password"
    render_password_reset_form(@operation)
  end

  private def render_password_reset_form(op)
    form_for PasswordResets::Create.with(@user_id) do
      mount Shared::Field, attribute: op.password, label_text: "Password", &.password_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field, attribute: op.password_confirmation, label_text: "Confirm Password", &.password_input(append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")

      submit "Update Password", flow_id: "update-password-button", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
