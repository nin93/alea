require "./spec_helper"

describe Alea do
  describe Alea::Random do
    describe "new" do
      it "creates a new instance from class" do
        Alea::Random(Alea::XSR128).new.should be_a(Alea::Random(Alea::XSR128))
      end

      it "creates a new instance from seeds" do
        Alea::Random(Alea::XSR128).new(12345).should be_a(Alea::Random(Alea::XSR128))
        Alea::Random(Alea::XSR128).new(12345, 54321).should be_a(Alea::Random(Alea::XSR128))
      end

      context "XSR128" do
        it "creates a new instance from class" do
          Alea::Random(Alea::XSR128).new.should be_a(Alea::Random(Alea::XSR128))
        end

        it "creates a new instance from seeds" do
          Alea::Random(Alea::XSR128).new(12345).should be_a(Alea::Random(Alea::XSR128))
          Alea::Random(Alea::XSR128).new(12345, 54321).should be_a(Alea::Random(Alea::XSR128))
        end
      end

      context "XSR256" do
        it "creates a new instance from class" do
          Alea::Random(Alea::XSR256).new.should be_a(Alea::Random(Alea::XSR256))
        end

        it "creates a new instance from seeds" do
          Alea::Random(Alea::XSR256).new(12345).should be_a(Alea::Random(Alea::XSR256))
          Alea::Random(Alea::XSR256).new(12345, 54321).should be_a(Alea::Random(Alea::XSR256))
        end
      end
    end

    it "generates sames numbers from same initial state concurrently" do
      rng1 = Alea::Random(Alea::XSR128).new 93
      rng2 = Alea::Random(Alea::XSR128).new 93

      1_000_000.times do
        rng1.next_u64.should eq(rng2.next_u64)
      end
    end

    it "generates different numbers from different initial state" do
      rng1 = Alea::Random(Alea::XSR128).new 93
      rng2 = Alea::Random(Alea::XSR128).new 193

      1_000_000.times do
        rng1.next_u64.should_not eq(rng2.next_u64)
      end
    end
  end
end
