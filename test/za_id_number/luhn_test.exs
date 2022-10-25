defmodule ZaIdNumber.LuhnTest do
  use ExUnit.Case

  use ExUnit.Case, async: true

  alias ZaIdNumber.Luhn

  describe "valid?" do
    test "me" do
      assert Luhn.valid?("79927398713")
    end

    test "American Express" do
      assert Luhn.valid?("378282246310005")
      assert Luhn.valid?("371449635398431")
    end

    test "American Express Corporate" do
      assert Luhn.valid?("378734493671000")
    end

    test "Australian BankCard" do
      assert Luhn.valid?("5610591081018250")
    end

    test "Diners Club" do
      assert Luhn.valid?("30569309025904")
      assert Luhn.valid?("38520000023237")
    end

    test "Discover" do
      assert Luhn.valid?("6011111111111117")
      assert Luhn.valid?("6011000990139424")
    end

    test "JCB" do
      assert Luhn.valid?("3530111333300000")
      assert Luhn.valid?("3566002020360505")
    end

    test "MasterCard" do
      assert Luhn.valid?("5555555555554444")
      assert Luhn.valid?("5105105105105100")
    end

    test "Visa" do
      assert Luhn.valid?("4111111111111111")
      assert Luhn.valid?("4012888888881881")
      assert Luhn.valid?("4222222222222")
    end

    test "Invalid numbers" do
      refute Luhn.valid?("123456789123456")
      refute Luhn.valid?("4111111511111112")
    end
  end
end
