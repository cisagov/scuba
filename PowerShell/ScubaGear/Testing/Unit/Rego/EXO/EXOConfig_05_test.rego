package exo_test
import rego.v1
import data.exo
import data.utils.key.TestResult
import data.utils.key.FAIL
import data.utils.key.PASS


#
# Policy MS.EXO.5.1v1
#--
test_SmtpClientAuthenticationDisabled_Correct if {
    Output := exo.tests with input.transport_config as [TransportConfig]

    TestResult("MS.EXO.5.1v1", Output, PASS, true) == true
}

test_SmtpClientAuthenticationDisabled_Incorrect if {
    TransportConfig1 := json.patch(TransportConfig, [{"op": "add", "path": "SmtpClientAuthenticationDisabled", "value": false}])

    Output := exo.tests with input.transport_config as [TransportConfig1]

    TestResult("MS.EXO.5.1v1", Output, FAIL, false) == true
}
#--