module Alea::Utils
  # Compile-time expansion for dist. definition checks over arguments.
  #
  # **@parameters**:
  # * `{{x}}`: parameter to check through `{{op}}` with `{{y}}`.
  # * `{{op}}`: operator that performs the comparison.
  # * `{{y}}`: parameter to check through `{{op}}` with `{{x}}`.
  # * `{{param}}`: name of the parameter to display in exception messages.
  # * `{{caller}}`: name of the method to display in exception messages.
  #
  # **@exceptions**:
  # * `Alea::UndefinedError` if `{{x}}` `{{op}}` `{{y}}` returns `true`.
  macro param_check(x, op, y, param, caller)
    if {{x.id}} {{op.id}} {{y.id}}
      # Distribution not defined under these conditions
      raise Alea::UndefinedError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}} {{op.id}} #{{{y.id}}}"
    end
  end
end
