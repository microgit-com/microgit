class Teams::Create < BrowserAction
  route do
    SaveTeam.create(params) do |operation, team|
      if team
        flash.success = "The record has been saved"
        redirect Show.with(team.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
