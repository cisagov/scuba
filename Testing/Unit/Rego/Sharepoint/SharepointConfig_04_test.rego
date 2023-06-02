package sharepoint
import future.keywords


#
# MS.SHAREPOINT.4.1v1
#--
test_SharingCapability_Correct_V1 if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 0,
                "ExternalUserExpirationRequired" : true,
                "ExternalUserExpireInDays": 30
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SharingCapability_Correct_V2 if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "ExternalUserExpirationRequired" : true,
                "ExternalUserExpireInDays": 30
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_ExternalUserExpireInDays_Correct if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "ExternalUserExpirationRequired" : true,
                "ExternalUserExpireInDays": 29
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Multi_Incorrect_V1 if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "ExternalUserExpirationRequired" : false,
                "ExternalUserExpireInDays": 31
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_ExternalUserExpirationRequired_Incorrect_V2 if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "ExternalUserExpirationRequired" : false,
                "ExternalUserExpireInDays": 29
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met: Expiration timer for 'Guest access to a site or OneDrive' NOT enabled"
}

test_ExternalUserExpireInDays_Incorrect_V3 if {
    PolicyId := "MS.SHAREPOINT.4.1v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "ExternalUserExpirationRequired" : true,
                "ExternalUserExpireInDays": 31
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met: Expiration timer for 'Guest access to a site or OneDrive' NOT set to 30 days or less"
}
#--

#
# MS.SHAREPOINT.4.2v1
#--
test_SharingCapability_Correct_V3 if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 0,
                "EmailAttestationRequired" : true,
                "EmailAttestationReAuthDays": 30
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SharingCapability_Correct_V4 if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "EmailAttestationRequired" : true,
                "EmailAttestationReAuthDays": 30
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_EmailAttestationReAuthDays_Correct if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "EmailAttestationRequired" : true,
                "EmailAttestationReAuthDays": 29
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Multi_Incorrect_V1 if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "EmailAttestationRequired" : false,
                "EmailAttestationReAuthDays": 31
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_EmailAttestationRequired_Incorrect_V2 if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "EmailAttestationRequired" : false,
                "EmailAttestationReAuthDays": 29
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met: Expiration timer for 'People who use a verification code' NOT enabled"
}

test_EmailAttestationReAuthDays_Incorrect_V3 if {
    PolicyId := "MS.SHAREPOINT.4.2v1"

    Output := tests with input as {
        "SPO_tenant": [
            {
                "SharingCapability" : 1,
                "EmailAttestationRequired" : true,
                "EmailAttestationReAuthDays": 31
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met: Expiration timer for 'People who use a verification code' NOT set to 30 days"
}
#--