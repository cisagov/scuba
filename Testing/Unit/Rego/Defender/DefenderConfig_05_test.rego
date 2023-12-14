package defender_test
import future.keywords
import data.defender
import data.utils.report.NotCheckedDetails
import data.utils.policy.CorrectTestResult
import data.utils.policy.IncorrectTestResult
import data.utils.policy.FAIL
import data.utils.policy.PASS


#
# Policy 1
#--
test_Disabled_Correct_V1 if {
    Output := defender.tests with input as {
        "protection_alerts": [
            {
                "Name": "Suspicious email sending patterns detected",
                "Disabled": false
            },
            {
                "Name": "Unusual increase in email reported as phish",
                "Disabled": false
            },
            {
                "Name": "Suspicious Email Forwarding Activity",
                "Disabled": false
            },
            {
                "Name": "Messages have been delayed",
                "Disabled": false
            },
            {
                "Name": "Tenant restricted from sending unprovisioned email",
                "Disabled": false
            },
            {
                "Name": "User restricted from sending email",
                "Disabled": false
            },
            {
                "Name": "Malware campaign detected after delivery",
                "Disabled": false
            },
            {
                "Name": "A potentially malicious URL click was detected",
                "Disabled": false
            },
            {
                "Name": "Suspicious connector activity",
                "Disabled": false
            }
        ]
    }

    CorrectTestResult("MS.DEFENDER.5.1v1", Output, PASS) == true
}

test_Disabled_Correct_V2 if {
    Output := defender.tests with input as {
        "protection_alerts": [
            {
                "Name": "Suspicious email sending patterns detected",
                "Disabled": false
            },
            {
                "Name": "Unusual increase in email reported as phish",
                "Disabled": false
            },
            {
                "Name": "Suspicious Email Forwarding Activity",
                "Disabled": false
            },
            {
                "Name": "Messages have been delayed",
                "Disabled": false
            },
            {
                "Name": "Tenant restricted from sending unprovisioned email",
                "Disabled": false
            },
            {
                "Name": "User restricted from sending email",
                "Disabled": false
            },
            {
                "Name": "Malware campaign detected after delivery",
                "Disabled": false
            },
            {
                "Name": "A potentially malicious URL click was detected",
                "Disabled": false
            },
            {
                "Name": "Suspicious connector activity",
                "Disabled": false
            },
            {
                "Name": "Successful exact data match upload",
                "Disabled": false
            }
        ]
    }

    CorrectTestResult("MS.DEFENDER.5.1v1", Output, PASS) == true
}

test_Disabled_Incorrect_V1 if {
    Output := defender.tests with input as {
        "protection_alerts": [
            {
                "Name": "Suspicious email sending patterns detected",
                "Disabled": true
            },
            {
                "Name": "Unusual increase in email reported as phish",
                "Disabled": false
            },
            {
                "Name": "Suspicious Email Forwarding Activity",
                "Disabled": false
            },
            {
                "Name": "Messages have been delayed",
                "Disabled": false
            },
            {
                "Name": "Tenant restricted from sending unprovisioned email",
                "Disabled": false
            },
            {
                "Name": "User restricted from sending email",
                "Disabled": false
            },
            {
                "Name": "Malware campaign detected after delivery",
                "Disabled": false
            },
            {
                "Name": "A potentially malicious URL click was detected",
                "Disabled": false
            },
            {
                "Name": "Suspicious connector activity",
                "Disabled": false
            }
        ]
    }

    ReportDetailString := "1 disabled required alert(s) found: Suspicious email sending patterns detected"
    IncorrectTestResult("MS.DEFENDER.5.1v1", Output, ReportDetailString) == true
}

test_Disabled_Incorrect_V2 if {
    Output := defender.tests with input as {
        "protection_alerts": [
            {
                "Name": "Unusual increase in email reported as phish",
                "Disabled": false
            },
            {
                "Name": "Suspicious Email Forwarding Activity",
                "Disabled": false
            },
            {
                "Name": "Messages have been delayed",
                "Disabled": false
            },
            {
                "Name": "Tenant restricted from sending unprovisioned email",
                "Disabled": false
            },
            {
                "Name": "User restricted from sending email",
                "Disabled": false
            },
            {
                "Name": "Malware campaign detected after delivery",
                "Disabled": false
            },
            {
                "Name": "A potentially malicious URL click was detected",
                "Disabled": false
            },
            {
                "Name": "Suspicious connector activity",
                "Disabled": false
            }
        ]
    }

    ReportDetailString := "1 disabled required alert(s) found: Suspicious email sending patterns detected"
    IncorrectTestResult("MS.DEFENDER.5.1v1", Output, ReportDetailString) == true
}
#--

#
# Policy 2
#--
test_NotImplemented_Correct_V2 if {
    PolicyId := "MS.DEFENDER.5.2v1"

    Output := defender.tests with input as { }

    ReportDetailString := NotCheckedDetails(PolicyId)
    IncorrectTestResult(PolicyId, Output, ReportDetailString) == true
}
#--