module Alea::Utils
  # Compile-time expansion for sanity (NaN/Infinity) checks over arguments.
  #
  # **@parameters**:
  # * `{{x}}`: parameter to check.
  # * `{{param}}`: name of the parameter to display in exception messages.
  # * `{{caller}}`: name of the method to display in exception messages.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if `{{x}}` is `NaN`.
  # * `Alea::InfinityError` if `{{x}}` is `Infinity`.
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
end
