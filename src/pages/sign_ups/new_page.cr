class SignUps::NewPage < AuthLayout
  needs operation : SignUpUser

  def content
    render_template "sign_ups/new_page.html.ecr"
  end

  private def render_sign_up_form(op)
    form_for SignUps::Create do
      sign_up_fields(op)
      link "Sign in instead", to: SignIns::New, class: "float-right inline-block py-2 px-4 font-bold"
      submit "Sign Up", flow_id: "sign-up-button", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end

  private def sign_up_fields(op)
    mount Shared::Field, attribute: op.username, label_text: "Username", &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
    mount Shared::Field, attribute: op.email, label_text: "Email", &.email_input(append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
    mount Shared::Field, attribute: op.password, label_text: "Password", &.password_input(append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
    mount Shared::Field, attribute: op.password_confirmation, label_text: "Confirm Password", &.password_input(append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
  end
end
