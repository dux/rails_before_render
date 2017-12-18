require 'digest'

module RailsBeforeRender
  @@_before_render ||= {}

  def self.included base
    def base.before_render_filter &block
      klass = self.to_s
      key   = Digest::MD5.hexdigest(caller[0])

      @@_before_render[klass]    ||= {}
      @@_before_render[klass][key] = block
    end
  end

  ###

  def render *args
    if @_was_in_render
      return performed? ? nil : super(*args)
    else
      @_was_in_render = true
    end

    self.class.ancestors.each do |klass|
      filters = @@_before_render[klass.to_s] || next
      filters.values.each do |filter|
        # do not run if render or redirect is called
        instance_exec &filter unless performed?
      end
    end

    # call native render unless redirect or render or redirect happend
    super unless performed?
  end
end

ActionController::Base.send :include, RailsBeforeRender