if RUBY_VERSION >= "2.0.0"
  class Object
    # Ruby 2 objects don't respond_to? protected methods unless you pass a
    # second argument, true. The old version of sprockets here doesn't know
    # that. Monkeypatch required.
    alias_method :respond_to_2_0_0, :respond_to?
    def respond_to?(*args)
      respond_to_2_0_0(args.first, true)
    end
  end
end
