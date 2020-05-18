require "./igausleg"

module Alea::Internal
  # Copyright (C) 2016-2020 Keith O'Hara
  # This file is part of the GCE-Math C++ library.
  # Licensed under the Apache License, Version 2.0 (the "License");
  # you may not use this file except in compiance with the License.
  # You may obtain a copy of the License at
  #
  #    http://www.apache.org/licenses/LICENSE-2.0
  #
  # Unless required by appicable law or agreed to in writing, software
  # distributed under the License is distributed on an "AS IS" BASIS,
  # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  # See the License for the specific language governing permissions and
  # limitations under the License.

  def self.incg_quad_itr(lwb, upb, a, lg)
    ig = 0.0
    50.times do |i|
      pi = GaussLegendre::Quad50::P[i]
      wi = GaussLegendre::Quad50::W[i]
      inp = ((upb - lwb) * pi + (upb + lwb)) * 0.5
      wgt = (upb - lwb) * wi * 0.5
      fnc = Math.exp(-inp + (a - 1.0) * Math.log(inp) - lg)
      ig += fnc * wgt
    end
    ig
  end

  def self.incg_quad_lwb(a, z)
    if a > 800.0
      Math.max(0.0, Math.min(z, a) - 11.0 * Math.sqrt(a))
    elsif a > 300.0
      Math.max(0.0, Math.min(z, a) - 10.0 * Math.sqrt(a))
    elsif a > 90.0
      Math.max(0.0, Math.min(z, a) - 9.0 * Math.sqrt(a))
    elsif a > 70.0
      Math.max(0.0, Math.min(z, a) - 8.0 * Math.sqrt(a))
    elsif a > 50.0
      Math.max(0.0, Math.min(z, a) - 7.0 * Math.sqrt(a))
    elsif a > 40.0
      Math.max(0.0, Math.min(z, a) - 6.0 * Math.sqrt(a))
    elsif a > 30.0
      Math.max(0.0, Math.min(z, a) - 5.0 * Math.sqrt(a))
    else
      Math.max(0.0, Math.min(z, a) - 4.0 * Math.sqrt(a))
    end
  end

  def self.incg_quad_upb(a, z)
    if a > 800.0
      Math.min(z, a + 10.0 * Math.sqrt(a))
    elsif a > 300.0
      Math.min(z, a + 9.0 * Math.sqrt(a))
    elsif a > 90.0
      Math.min(z, a + 8.0 * Math.sqrt(a))
    elsif a > 70.0
      Math.min(z, a + 7.0 * Math.sqrt(a))
    elsif a > 50.0
      Math.min(z, a + 6.0 * Math.sqrt(a))
    elsif a > 40.0
      Math.min(z, a + 5.0 * Math.sqrt(a))
    else
      Math.min(z, a + 4.0 * Math.sqrt(a))
    end
  end

  def self.incg_quad(a, z)
    fraglw = self.incg_quad_lwb(a, z)
    fragup = self.incg_quad_upb(a, z)
    self.incg_quad_itr(fraglw, fragup, a, Math.lgamma(a))
  end

  def self.incg_cnfr(a, z)
    Math.exp(a * Math.log(z) - z) / Math.gamma(a) / self.incg_cnfr_itr(a, z)
  end

  def self.incg_cnfr_itr(a, z)
    fr = a + 54
    54.times do |i|
      # if even
      ci = if i & 1 == 0
             (z * 0.5 * (54 - i))
           else
             -(a - 1.0 + (55 - i) * 0.5) * z
           end
      fr = (a + (53 - i)) + ci / fr
    end
    fr
  end

  def self.incg_regular_lower(a, x)
    if a < 10.0
      self.incg_cnfr(a, x)
    else
      self.incg_quad(a, x)
    end
  end

  def self.incg_regular_upper(a, x)
    1.0 - self.incg_regular_lower(a, x)
  end
end
