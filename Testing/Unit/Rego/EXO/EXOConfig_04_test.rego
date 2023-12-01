package exo_test
import future.keywords
import data.exo


#
# Policy 1
#--
test_Rdata_Correct if {
    PolicyId := "MS.EXO.4.1v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Rdata_Incorrect if {
    PolicyId := "MS.EXO.4.1v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

test_Rdata_Incorrect_V2 if {
    PolicyId := "MS.EXO.4.1v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

test_Rdata_Incorrect_V3 if {
    PolicyId := "MS.EXO.4.1v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "test.name"
            },
            {
                "rdata": [],
                "domain": "bad.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "bad.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 2 agency domain(s) found in violation: bad.name"
}
#--

#
# Policy 2
#--
test_Rdata_Correct_V2 if {
    PolicyId := "MS.EXO.4.2v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_Rdata_Incorrect_V4 if {
    PolicyId := "MS.EXO.4.2v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=none; mailto:reports@dmarc.cyber.dhs.gov mailto:jsmith@dhs.gov mailto:jsomething@dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

test_Rdata_Incorrect_V5 if {
    PolicyId := "MS.EXO.4.2v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; mailto:reports@dmarc.cyber.dhs.gov mailto:jsmith@dhs.gov mailto:jsomething@dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}
#--

#
# Policy 3
#--
test_DMARCReport_Correct_V1 if {
    PolicyId := "MS.EXO.4.3v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

test_DMARCReport_Incorrect_V1 if {
    PolicyId := "MS.EXO.4.3v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100;"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

test_DMARCReport_Incorrect_V2 if {
    PolicyId := "MS.EXO.4.3v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@wrong.address"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

# empty rdata
test_DMARCReport_Incorrect_V3 if {
    PolicyId := "MS.EXO.4.3v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}
#--

#
# Policy 4
#--

# 2 emails in rua= and 1 in ruf
test_POC_Correct_V1 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov; ruf=agencyemail@hq.dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

# 2+ emails in rua= and 1+ in ruf
test_POC_Correct_V1 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:DMARC@hq.dhs.gov, mailto:reports@dmarc.cyber.dhs.gov, mailto:test@example.com; ruf=agencyemail@hq.dhs.gov, test@test.com"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == true
    RuleOutput[0].ReportDetails == "Requirement met"
}

# Only 1 rua
test_POC_Incorrect_V1 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

# Only 2 emails in rua no ruf
test_POC_Incorrect_V2 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov, test@exo.com"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

# Only 1 ruf no rua
test_POC_Incorrect_V3 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=test@exo.com"
                ],
                "domain": "test.name"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 1 agency domain(s) found in violation: test.name"
}

# 2 domains 1 fails rua/ruf number
test_POC_Incorrect_V4 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov, test@test.name ruf=test2@test.name"
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov"
                ],
                "domain": "example.com"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "example.com"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 2 agency domain(s) found in violation: example.com"
}

# 2 domains 1 fails rua # of email policy requirement
test_POC_Incorrect_V5 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov, test@test.name ruf=test2@test.name"
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov; ruf=test@exo.com"
                ],
                "domain": "example.com"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "example.com"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 2 agency domain(s) found in violation: example.com"
}

# 2 domains 1 domain failed DNS query. Empty rdata
test_POC_Incorrect_V5 if {
    PolicyId := "MS.EXO.4.4v1"

    Output := exo.tests with input as {
        "dmarc_records": [
            {
                "rdata": [
                    "v=DMARC1; p=reject; pct=100; rua=mailto:reports@dmarc.cyber.dhs.gov, test@test.name ruf=test2@test.name"
                ],
                "domain": "test.name"
            },
            {
                "rdata": [],
                "domain": "example.com"
            }
        ],
        "spf_records": [
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "test.name"
            },
            {
                "rdata": [
                    "spf1 "
                ],
                "domain": "example.com"
            }
        ]
    }

    RuleOutput := [Result | some Result in Output; Result.PolicyId == PolicyId]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet == false
    RuleOutput[0].ReportDetails == "1 of 2 agency domain(s) found in violation: example.com"
}
#--