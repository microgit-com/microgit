module Lucky::HTMLBuilder
  macro render_template(template)
    Kilt.embed "src/pages/{{template.id}}", io_name: view
  end
end
