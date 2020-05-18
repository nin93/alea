module Alea
  class UndefinedError < Exception; end

  class NaNError < Exception; end

  class InfinityError < Exception; end

  class NoConvergeError < Exception; end

  macro sanity_check(x, param, caller)
    if !({{x.id}} == {{x.id}})
      # NaN encountered
      raise Alea::NaNError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}}"
    elsif {{x.id}} != 0.0 && {{x.id}} * 2.0 == {{x.id}}
      # Infinity encountered
      raise Alea::InfinityError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}}"
    end
  end

  macro param_check(x, comp, y, param, caller)
    if {{x.id}} {{comp.id}} {{y.id}}
      raise Alea::UndefinedError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}} {{comp.id}} #{{{y.id}}}"
    end
  end
end
