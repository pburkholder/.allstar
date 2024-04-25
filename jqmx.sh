grep '^{' ./allstar.log |
 jq --slurp '[.[] | select(.enabled == true and .message == "Policy run result.") ] |
            [ group_by(.area)[] | 
               {(.[0].area): (
               { "fail": [ .[] | select(.result == false) | .repo]},
               { "pass": [ .[] | select(.result == true)  | .repo]}
               )
                }]'
