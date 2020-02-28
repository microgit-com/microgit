class Blobs::Show < BrowserAction
  get "/:namespace_slug/:repository_slug/blob/:branch_name/:path" do
    plain_text "blob show for #{namespace_slug}/#{repository_slug}/#{branch_name}/#{path}"
  end
end
