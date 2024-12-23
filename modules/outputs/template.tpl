{
    "Resources" : {
        %{ for resource in resources ~}
            %{if index(resources, resource)  >= 1} , %{endif}
            "${resource.name}": {
            "Type": "AWS::SSM::Parameter",
                "Properties": {
                    "Name": "${project_name}-${stage}-${resource.name}",
                    "Type": "String",
                    "Value": "${resource.value}"
                }
            }
        %{ endfor ~}
    },
    "Outputs": {
        %{ for resource in resources ~}
            %{if index(resources, resource)  >= 1} , %{endif}
            "${resource.name}": {
                "Value": "${resource.value}"
            }
        %{ endfor ~}
    }
}