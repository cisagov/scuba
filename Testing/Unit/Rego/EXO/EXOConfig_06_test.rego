package exo_test
import future.keywords
import data.exo
import data.utils.policy.CorrectTestResult
import data.utils.policy.IncorrectTestResult
import data.utils.policy.PASS


#
# Policy 1
#--
test_Domains_Contacts_Correct if {
    Output := exo.tests with input as {
        "sharing_policy": [
            {
                "Domains": [
                    "domain1",
                    "domain2"
                ],
                "Name": "A"
            }
        ]
    }

    CorrectTestResult("MS.EXO.6.1v1", Output, PASS) == true
}

test_Domains_Contacts_Incorrect if {
    Output := exo.tests with input as {
        "sharing_policy": [
            {
                "Domains": [
                    "*:ContactsSharing",
                    "domain1:CalendarSharingFreeBusyDetail"
                ],
                "Name": "A"
            }
        ]
    }

    ReportDetailString := "1 sharing polic(ies) are sharing contacts folders with all domains by default: A"
    IncorrectTestResult("MS.EXO.6.1v1", Output, ReportDetailString) == true

    # print(count(RuleOutput)==1)
    # notror := RuleOutput[0].RequirementMet
    # trace(notror)
    # print(RuleOutput[0].ReportDetails == "Wildcard domain (\"*\") in shared domains list, enabling sharing will all domains by default")
}

#
# Policy 2
#--
test_Domains_Calendar_Correct if {
    Output := exo.tests with input as {
        "sharing_policy": [
            {
                "Domains": [
                    "domain1",
                    "domain2"
                ],
                "Name": "A"
            }
        ]
    }

    CorrectTestResult("MS.EXO.6.2v1", Output, PASS) == true
}

test_Domains_Calendar_Incorrect if {
    Output := exo.tests with input as {
        "sharing_policy": [
            {
                "Domains": [
                    "*:CalendarSharingFreeBusyDetail",
                    "domain1:ContactsSharing"
                ],
                "Name": "A"
            }
        ]
    }

    ReportDetailString := "1 sharing polic(ies) are sharing calendar details with all domains by default: A"
    IncorrectTestResult("MS.EXO.6.2v1", Output, ReportDetailString) == true
}
#--