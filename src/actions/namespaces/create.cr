class Namespaces::Create < BrowserAction
  route do
    SaveNamespace.create(params) do |operation, namespace|
      if namespace
        flash.success = "The record has been saved"
        redirect Show.with(namespace.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
