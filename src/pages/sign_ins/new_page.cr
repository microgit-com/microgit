class SignIns::NewPage < AuthLayout
  needs operation : SignInUser

  def content
    render_sign_in_form(@operation)
  end

  private def render_sign_in_form(op)
    div class: "bg-white shadow-lg rounded p-4" do
      h1 "Sign In", class: "mb-3"
      form_for SignIns::Create do
        sign_in_fields(op)
        submit "Sign In", flow_id: "sign-in-button", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
      end
      para class: "pt-3" do
        link "Reset password", to: PasswordResetRequests::New
        text " | "
        link "Sign up", to: SignUps::New
      end
    end
  end

  private def sign_in_fields(op)
    mount Shared::Field, attribute: op.email, label_text: "Email", &.email_input(autofocus: "true", append_class: "appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
    mount Shared::Field, attribute: op.password, label_text: "Password", &.password_input(append_class: "appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
  end
end
