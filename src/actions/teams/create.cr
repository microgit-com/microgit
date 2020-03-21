class Teams::Create < BrowserAction
  route do
    SaveTeam.create(params, created_by: current_user) do |operation, team|
      if team
        flash.success = "The record has been saved"
        redirect Namespaces::Show.with(team.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
