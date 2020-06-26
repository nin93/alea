require "./spec_helper"

describe Alea do
  describe Alea::Random do
    describe "new" do
      it "creates a new instance from class" do
        Alea::Random.new.should be_a(Alea::Random)
      end

      it "creates a new instance from seeds" do
        Alea::Random.new(12345).should be_a(Alea::Random)
        Alea::Random.new(12345, 54321).should be_a(Alea::Random)
      end

      context "XSR128" do
        it "creates a new instance from class" do
          Alea::Random.new(Alea::XSR128).should be_a(Alea::Random)
        end

        it "creates a new instance from seeds" do
          Alea::Random.new(12345, Alea::XSR128).should be_a(Alea::Random)
          Alea::Random.new(12345, 54321, Alea::XSR128).should be_a(Alea::Random)
        end
      end

      context "XSR256" do
        it "creates a new instance from class" do
          Alea::Random.new(Alea::XSR256).should be_a(Alea::Random)
        end

        it "creates a new instance from seeds" do
          Alea::Random.new(12345, Alea::XSR256).should be_a(Alea::Random)
          Alea::Random.new(12345, 54321, Alea::XSR256).should be_a(Alea::Random)
        end
      end
    end

    it "generates sames numbers from same initial state concurrently" do
      rng1 = Alea::Random.new 93
      rng2 = Alea::Random.new 93

      1_000_000.times do
        rng1.next_u64.should eq(rng2.next_u64)
      end
    end

    it "generates different numbers from different initial state" do
      rng1 = Alea::Random.new 93
      rng2 = Alea::Random.new 193

      1_000_000.times do
        rng1.next_u64.should_not eq(rng2.next_u64)
      end
    end
  end
end
