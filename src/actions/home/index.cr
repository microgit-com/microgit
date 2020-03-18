class Home::Index < BrowserAction
  include Auth::AllowGuests

  get "/" do
    if current_user?
      redirect Namespaces::Show.with(namespace_slug: current_user.not_nil!.namespace!.slug)
    else
      # When you're ready change this line to:
      #
      #   redirect SignIns::New
      #
      # Or maybe show signed out users a marketing page:
      #
      #   html Marketing::IndexPage
      html Home::WelcomePage
    end
  end
end
