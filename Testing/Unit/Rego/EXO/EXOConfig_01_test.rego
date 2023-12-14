package exo_test
import future.keywords
import data.exo
import data.utils.policy.CorrectTestResult
import data.utils.policy.IncorrectTestResult
import data.utils.policy.PASS


#
# Policy 1
#--
test_AutoForwardEnabled_Correct if {
    Output := exo.tests with input as {
        "remote_domains": [
            {
                "AutoForwardEnabled": false,
                "DomainName": "Test name"
            }
        ]
    }

    CorrectTestResult("MS.EXO.1.1v1", Output, PASS) == true
}

test_AutoForwardEnabled_Incorrect_V1 if {
    Output := exo.tests with input as {
        "remote_domains": [
            {
                "AutoForwardEnabled": true,
                "DomainName": "Test name"
            }
        ]
    }

    ReportDetailString := "1 remote domain(s) that allows automatic forwarding: Test name"
    IncorrectTestResult("MS.EXO.1.1v1", Output, ReportDetailString) == true
}

test_AutoForwardEnabled_Incorrect_V2 if {
    Output := exo.tests with input as {
        "remote_domains": [
            {
                "AutoForwardEnabled": true,
                "DomainName": "Test name"
            },
            {
                "AutoForwardEnabled": true,
                "DomainName": "Test name 2"
            }
        ]
    }

    ReportDetailString := "2 remote domain(s) that allows automatic forwarding: Test name, Test name 2"
    IncorrectTestResult("MS.EXO.1.1v1", Output, ReportDetailString) == true
}

test_AutoForwardEnabled_Incorrect_V3 if {
    Output := exo.tests with input as {
        "remote_domains": [
            {
                "AutoForwardEnabled": true,
                "DomainName": "Test name"
            },
            {
                "AutoForwardEnabled": true,
                "DomainName": "Test name 2"
            },
            {
                "AutoForwardEnabled": false,
                "DomainName": "Test name 3"
            }
        ]
    }

    ReportDetailString := "2 remote domain(s) that allows automatic forwarding: Test name, Test name 2"
    IncorrectTestResult("MS.EXO.1.1v1", Output, ReportDetailString) == true
}
#--