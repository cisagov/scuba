package exo_test
import future.keywords
import data.exo


#
# Policy 1
#--
test_SmtpClientAuthenticationDisabled_Correct if {
    PolicyId := "MS.EXO.5.1v1"

    Output := exo.tests with input as {
        "transport_config": [
            {
                "SmtpClientAuthenticationDisabled": true,
                "Name": "A"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SmtpClientAuthenticationDisabled_Incorrect if {
    PolicyId := "MS.EXO.5.1v1"

    Output := exo.tests with input as {
        "transport_config": [
            {
                "SmtpClientAuthenticationDisabled": false,
                "Name": "A"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "Requirement not met"
}
#--