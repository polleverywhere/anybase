# frozen_string_literal: true

require "spec_helper"

RSpec.describe Anybase, "util" do
  it "should tell you the size for an arbitrary number of digits" do
    expect(Anybase.new("012345678").size(10)).to eq(3_486_784_401)
    expect(Anybase.new("012345678").size(10) * Anybase.new("012345678").size(10)).to eq(Anybase.new("012345678").size(20))
  end

  it "should normalize a number" do
    expect(Anybase.new("01", synonyms: { "0" => "o", "1" => "l" }, ignore_case: true).normalize("l10oO1o")).to eq("1100010")
  end

  it "raises if the negative sign is in the chars" do
    expect { Anybase.new("01", negative_sign: "0") }.to raise_error(Anybase::NegativeSignListedAsDigitError)
  end

  it "raises if the negative sign is longer than one character" do
    expect { Anybase.new("01", negative_sign: "++") }.to raise_error(Anybase::NegativeSignTooLongError)
  end

  it "should allow matching" do
    funny_octal = Anybase.new("012345678", synonyms: { "0" => "oO" })
    expect(funny_octal.match("235O")).to eq("235O")
    expect(funny_octal.match("235Ozzz")).to eq("235O")
    expect(funny_octal.match("a235O")).to eq(nil)
  end
end
