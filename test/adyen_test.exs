defmodule AdyenTest do
  use ExUnit.Case
  doctest Adyen

  test "it returns a list of banks" do
    assert {
             :ok,
             [
               %{issuer_id: 1121, name: "Test Issuer"},
               %{issuer_id: 1154, name: "Test Issuer 5"},
               %{issuer_id: 1153, name: "Test Issuer 4"},
               %{issuer_id: 1152, name: "Test Issuer 3"},
               %{issuer_id: 1151, name: "Test Issuer 2"},
               %{issuer_id: 1162, name: "Test Issuer Cancelled"},
               %{issuer_id: 1161, name: "Test Issuer Pending"},
               %{issuer_id: 1160, name: "Test Issuer Refused"},
               %{issuer_id: 1159, name: "Test Issuer 10"},
               %{issuer_id: 1158, name: "Test Issuer 9"},
               %{issuer_id: 1157, name: "Test Issuer 8"},
               %{issuer_id: 1156, name: "Test Issuer 7"},
               %{issuer_id: 1155, name: "Test Issuer 6"}
             ]
           } = Adyen.banks()
  end

  test "it returns a list of bank issuers" do
    assert {
             :ok,
             [
               1121,
               1154,
               1153,
               1152,
               1151,
               1162,
               1161,
               1160,
               1159,
               1158,
               1157,
               1156,
               1155
             ]
           } = Adyen.issuer_ids()
  end

  test "it returns a redirect url to adyen where you can select a bank" do
    assert {
             :ok,
             "https://test.adyen.com/hpp/pay.shtml?brandCode=ideal&currencyCode=EUR" <> _rest
           }
           = Adyen.request_payment(amount_in_cents: 10000)
  end

  test "it returns a redirect url to adyen with a preselected bank" do
    assert {
             :ok,
             "https://test.adyen.com/hpp/skipDetails.shtml?brandCode=ideal&currencyCode=EUR&issuerId=1151" <> _rest
           }
           = Adyen.request_payment(amount_in_cents: 10000, issuer_id: 1151)
  end

  test "it needs at last an amount in cents" do
    assert {:error, [amount_in_cents: "can't be blank"]} = Adyen.request_payment(%{})
  end
end
