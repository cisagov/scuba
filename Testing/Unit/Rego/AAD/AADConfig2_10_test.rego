package aad
import future.keywords


#
# Policy 1
#--
test_ConditionalAccessPolicies_Correct if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "1 conditional access policy(s) found that meet(s) all requirements:<br/>Test Name. <a href='#caps'>View all CA policies</a>."
}

test_IncludeApplications_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": []
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_IncludeUsers_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": [],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_ExcludeUsers_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": ["4b8dda31-c541-4e2d-aa7f-5f6e1980dc90"],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_ExcludeGroups_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": ["4b8dda31-c541-4e2d-aa7f-5f6e1980dc90"],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_ExcludeRoles_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": ["4b8dda31-c541-4e2d-aa7f-5f6e1980dc90"]
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_IsEnabled_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : false,
                        "Mode" : "never"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_Mode_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "always"
                    }
                },
                "State": "enabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}

test_State_Incorrect if {
    ControlNumber := "AAD 2.10"
    Requirement := "Browser sessions SHALL not be persistent"

    Output := tests with input as {
        "conditional_access_policies": [
            {
                "Conditions": {
                    "Applications": {
                        "IncludeApplications": ["All"]
                    },
                    "Users": {
                        "IncludeUsers": ["All"],
                        "ExcludeUsers": [],
                        "ExcludeGroups": [],
                        "ExcludeRoles": []
                    }
                },
                "SessionControls": {
                    "PersistentBrowser": {
                        "IsEnabled" : true,
                        "Mode" : "never"
                    }
                },
                "State": "disabled",
                "DisplayName" : "Test Name"
            }
        ]
    }

    RuleOutput := [Result | Result = Output[_]; Result.Control == ControlNumber; Result.Requirement == Requirement]

    count(RuleOutput) == 1
    not RuleOutput[0].RequirementMet
    RuleOutput[0].ReportDetails == "0 conditional access policy(s) found that meet(s) all requirements. <a href='#caps'>View all CA policies</a>."
}