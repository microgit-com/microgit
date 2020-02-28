class Commits::Show < BrowserAction
  get "/:namespace_slug/:repository_slug/commit/:branch_name/:sha" do
    plain_text "Render something in Commit::Show"
  end
end
