# frozen_string_literal: true

require "spec_helper"

describe Decidim::Message do
  let(:message) { build(:message) }
  subject { message }

  it { is_expected.to be_valid }
end
