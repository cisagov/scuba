package defender
import future.keywords

#
# Policy 1
#--
test_Enabled_Correct_V1 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Enabled"
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "State" : "Enabled"
            }
        ],
        "atp_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Enabled"
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "State" : "Enabled"
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Enabled_Correct_V2 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Enabled"
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "State" : "Enabled"
            }
        ],
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Enabled_Correct_V3 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [],
        "atp_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Enabled"
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "State" : "Enabled"
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Enabled_Incorrect_V1 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [],
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]
    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Standard and Strict preset policies are both disabled"
}

test_Enabled_Incorrect_V2 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Disabled"
            }
        ],
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Standard and Strict preset policies are both disabled"
}

test_Enabled_Incorrect_V3 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Enabled"
            }
        ],
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Strict preset policy is disabled"
}

test_Enabled_Incorrect_V4 if {
    PolicyId := "MS.DEFENDER.1.1v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "State" : "Disabled"
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "State" : "Disabled"
            }
        ],
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]
    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Standard and Strict preset policies are both disabled"
}
#--

#
# Policy 2
#--
test_AllEOP_Correct_V1 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllEOP_Correct_V2 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllEOP_Correct_V3 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllEOP_Incorrect_V1 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : []
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_AllEOP_Incorrect_V2 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_AllEOP_Incorrect_V3 if {
    PolicyId := "MS.DEFENDER.1.2v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            },
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": ["example.com"]
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}
#--

#
# Policy 3
#--
test_AllDefender_Correct_V1 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllDefender_Correct_V2 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllDefender_Correct_V3 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            },
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_AllDefender_Incorrect_V1 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_AllDefender_Incorrect_V2 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_AllDefender_Incorrect_V3 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": ["user@example.com"],
                "SentToMemberOf": null,
                "RecipientDomainIs": null
            },
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": ["example.com"]
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_AllDefender_Incorrect_V4 if {
    PolicyId := "MS.DEFENDER.1.3v1"

    Output := tests with input as {
        "atp_policy_rules" : [],
        "defender_license": false
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met **NOTE: Either you do not have sufficient permissions or your tenant does not have a license for Microsoft Defender for Office 365 Plan 1, which is required for this feature.**"
}

#
# Policy 4
#--
test_SensitiveEOP_Correct_V1 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V2 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V3 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": [
                    "dune@random.example.com"
                ],
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V4 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V5 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": [
                    "janedoe@random.example.com"
                ],
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com"
                        ],
                        "Groups" : [],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V6 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": [
                    "dune@random.example.com"
                ],
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": [
                    "dune12@random.example.com"
                ],
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V7 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": [
                    "randomdancing.mail.example.com"
                ],
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V8 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": [
                    "randomdancing.mail.example.com"
                ],
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com",
                            "random.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V9 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com",
                    "janedoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com",
                            "janedoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V10 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": [
                    "dune@random.example.com",
                    "dune12@random.example.com"
                ],
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com",
                            "dune12@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V11 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com",
                    "randomdancing.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com",
                            "randomdancing.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V12 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com",
                    "janedoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V13 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": [
                    "dune@random.example.com",
                    "dune12@random.example.com"
                ],
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V14 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com",
                    "randomdancing.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V15 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com",
                    "janedoe@random.example.com",
                    "johndoe@random.mail.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com",
                            "janedoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : [
                            "random.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Correct_V16 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com",
                    "janedoe@random.example.com",
                    "johndoe@random.mail.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "randomdancing.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com",
                            "janedoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : [
                            "random.mail.example.com",
                            "randomdancing.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveEOP_Incorrect_V1 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Standard Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V2 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [ ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V3 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": [
                    "johndoe@random.example.com"
                ],
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com"
                        ],
                        "Groups" : [],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V4 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": [
                    "dune@random.example.com"
                ],
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V5 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": [
                    "random.mail.example.com"
                ],
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V6 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": [
                    "randomdancing.mail.example.com"
                ],
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com",
                            "random.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Incorrect_V7 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": [
                    "randomdancing.mail.example.com",
                    "random.example.com"
                ],
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com",
                            "random.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Correct_V8 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": [
                    "johndoe@random.example.com"
                ],
                "SentToMemberOf": null,
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [
                            "johndoe@random.example.com",
                            "janedoe@random.example.com"
                        ],
                        "Groups" : [ ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Correct_V9 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": [
                    "dune@random.example.com"
                ],
                "RecipientDomainIs": null,
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [
                            "dune@random.example.com",
                            "dune12@random.example.com"
                        ],
                        "Domains" : []
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveEOP_Correct_V10 if {
    PolicyId := "MS.DEFENDER.1.4v1"

    Output := tests with input as {
        "protection_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy",
                "SentTo": null,
                "SentToMemberOf": null,
                "RecipientDomainIs": [
                    "random.mail.example.com"
                ],
                "ExceptIfSentTo": null,
                "ExceptIfSentToMemberOf": null,
                "ExceptIfRecipientDomainIs": null,
            }
        ],
        "scuba_config" : {
            "Defender" : {
                "MS.DEFENDER.1.4v1" : {
                    "SensitiveAccounts" : {
                        "Users" : [],
                        "Groups" : [],
                        "Domains" : [
                            "random.mail.example.com",
                            "randomdancing.mail.example.com"
                        ]
                    }
                }
            }
        },
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}
#--

#
# Policy 5
#--
test_SensitiveAtp_Correct_V1 if {
    PolicyId := "MS.DEFENDER.1.5v1"

    Output := tests with input as {
        "atp_policy_rules" : [
            {
                "Identity" : "Strict Preset Security Policy"
            }
        ],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_SensitiveAtp_Incorrect_V1 if {
    PolicyId := "MS.DEFENDER.1.5v1"

    Output := tests with input as {
        "atp_policy_rules" : [],
        "defender_license": true
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met"
}

test_SensitiveAtp_Incorrect_V2 if {
    PolicyId := "MS.DEFENDER.1.5v1"

    Output := tests with input as {
        "atp_policy_rules" : [],
        "defender_license": false
    }

    RuleOutput := [Result | Result = Output[_]; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "Requirement not met **NOTE: Either you do not have sufficient permissions or your tenant does not have a license for Microsoft Defender for Office 365 Plan 1, which is required for this feature.**"
}
#--